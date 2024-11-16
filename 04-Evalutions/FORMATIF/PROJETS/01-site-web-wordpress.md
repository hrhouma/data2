
```bash

AWSTemplateFormatVersion: '2010-09-09'
Description: WordPress infrastructure with RDS, ElastiCache, and CloudFront

Parameters:
  KeyPairName:
    Type: AWS::EC2::KeyPair::KeyName
    Description: Name of an existing EC2 KeyPair to enable SSH access to the instance

Resources:
  # VPC and Networking
  MyVPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: 10.0.0.0/16
      EnableDnsSupport: true
      EnableDnsHostnames: true
      Tags:
        - Key: Name
          Value: WordPressVPC

  InternetGateway:
    Type: AWS::EC2::InternetGateway

  AttachGateway:
    Type: AWS::EC2::VPCGatewayAttachment
    Properties:
      VpcId: !Ref MyVPC
      InternetGatewayId: !Ref InternetGateway

  PublicSubnet1:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref MyVPC
      CidrBlock: 10.0.1.0/24
      AvailabilityZone: !Select [ 0, !GetAZs '' ]
      MapPublicIpOnLaunch: true
      Tags:
        - Key: Name
          Value: WordPressPublicSubnet1

  PublicSubnet2:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref MyVPC
      CidrBlock: 10.0.2.0/24
      AvailabilityZone: !Select [ 1, !GetAZs '' ]
      MapPublicIpOnLaunch: true
      Tags:
        - Key: Name
          Value: WordPressPublicSubnet2

  PublicRouteTable:
    Type: AWS::EC2::RouteTable
    Properties:
      VpcId: !Ref MyVPC
      Tags:
        - Key: Name
          Value: WordPressPublicRouteTable

  PublicRoute:
    Type: AWS::EC2::Route
    DependsOn: AttachGateway
    Properties:
      RouteTableId: !Ref PublicRouteTable
      DestinationCidrBlock: 0.0.0.0/0
      GatewayId: !Ref InternetGateway

  PublicSubnet1RouteTableAssociation:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties:
      SubnetId: !Ref PublicSubnet1
      RouteTableId: !Ref PublicRouteTable

  PublicSubnet2RouteTableAssociation:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties:
      SubnetId: !Ref PublicSubnet2
      RouteTableId: !Ref PublicRouteTable

  # Security Groups
  EC2SecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: Allow SSH and HTTP
      VpcId: !Ref MyVPC
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 22
          ToPort: 22
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: 80
          ToPort: 80
          CidrIp: 0.0.0.0/0

  RDSSecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: Allow MySQL access from EC2
      VpcId: !Ref MyVPC
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 3306
          ToPort: 3306
          SourceSecurityGroupId: !Ref EC2SecurityGroup

  RedisSecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: Allow Redis access from EC2
      VpcId: !Ref MyVPC
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 6379
          ToPort: 6379
          SourceSecurityGroupId: !Ref EC2SecurityGroup

  # EC2 Instance
  WordPressInstance:
    Type: AWS::EC2::Instance
    Properties:
      InstanceType: t3.micro
      SecurityGroupIds:
        - !Ref EC2SecurityGroup
      SubnetId: !Ref PublicSubnet1
      ImageId: ami-0aa7d40eeae50c9a9  # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
      KeyName: !Ref KeyPairName
      UserData:
        Fn::Base64: !Sub |
          #!/bin/bash
          yum update -y
          amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
          yum install -y httpd mariadb-server
          systemctl start httpd
          systemctl enable httpd
          wget https://wordpress.org/latest.tar.gz
          tar -xzf latest.tar.gz
          cp -r wordpress/* /var/www/html/
          chown -R apache:apache /var/www/html/
          chmod -R 755 /var/www/html/
          systemctl restart httpd

  # RDS Database
  RDSSubnetGroup:
    Type: AWS::RDS::DBSubnetGroup
    Properties:
      DBSubnetGroupDescription: Subnet group for RDS
      SubnetIds: 
        - !Ref PublicSubnet1
        - !Ref PublicSubnet2

  WordPressDB:
    Type: AWS::RDS::DBInstance
    Properties:
      DBName: wordpressdb
      Engine: MySQL
      MasterUsername: admin
      MasterUserPassword: !Join ['', ['{{resolve:secretsmanager:', !Ref RDSSecret, ':SecretString:password}}' ]]
      DBInstanceClass: db.t3.micro
      AllocatedStorage: 20
      PubliclyAccessible: false
      VPCSecurityGroups:
        - !Ref RDSSecurityGroup
      DBSubnetGroupName: !Ref RDSSubnetGroup

  RDSSecret:
    Type: AWS::SecretsManager::Secret
    Properties:
      Name: RDSSecret
      GenerateSecretString:
        SecretStringTemplate: '{"username": "admin"}'
        GenerateStringKey: password
        PasswordLength: 16
        ExcludeCharacters: '"@/\'

  # ElastiCache Redis
  RedisSubnetGroup:
    Type: AWS::ElastiCache::SubnetGroup
    Properties:
      Description: Subnet group for Redis cluster
      SubnetIds: 
        - !Ref PublicSubnet1
        - !Ref PublicSubnet2

  RedisCache:
    Type: AWS::ElastiCache::CacheCluster
    Properties:
      Engine: redis
      CacheNodeType: cache.t3.micro
      NumCacheNodes: 1
      VpcSecurityGroupIds:
        - !Ref RedisSecurityGroup
      CacheSubnetGroupName: !Ref RedisSubnetGroup

  # CloudFront Distribution
  WordPressDistribution:
    Type: AWS::CloudFront::Distribution
    Properties:
      DistributionConfig:
        Origins:
          - DomainName: !GetAtt WordPressInstance.PublicDnsName
            Id: WordPressOrigin
            CustomOriginConfig:
              HTTPPort: 80
              HTTPSPort: 443
              OriginProtocolPolicy: http-only
        Enabled: true
        DefaultCacheBehavior:
          TargetOriginId: WordPressOrigin
          ViewerProtocolPolicy: redirect-to-https
          ForwardedValues:
            QueryString: true
            Cookies:
              Forward: all
        ViewerCertificate:
          CloudFrontDefaultCertificate: true

Outputs:
  WebsiteURL:
    Description: WordPress Website URL
    Value: !Sub 'http://${WordPressInstance.PublicDnsName}'
  CloudFrontURL:
    Description: CloudFront Distribution URL
    Value: !Sub 'https://${WordPressDistribution.DomainName}'
  RDSEndpoint:
    Description: RDS Endpoint
    Value: !GetAtt WordPressDB.Endpoint.Address
  RedisEndpoint:
    Description: Redis Endpoint
    Value: !GetAtt RedisCache.RedisEndpoint.Address


```
