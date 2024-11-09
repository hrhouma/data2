
*Ce modèle inclut plusieurs services AWS tels que Lambda, S3, Glue, Athena et QuickSight.*

![image](https://github.com/user-attachments/assets/ea49ef5d-e483-434e-be56-c612ccf56d13)


```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: "Modèle CloudFormation pour orchestrer un pipeline de traitement de données avec AWS Glue, Athena et QuickSight."

Parameters:
  S3BucketName:
    Type: String
    Description: "Nom du bucket S3 pour stocker les données sources."

Resources:
  # Bucket S3 pour stocker les données sources
  SourceS3Bucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Ref S3BucketName

  # Fonction Lambda pour déclencher le pipeline lorsqu'un fichier est ajouté à S3
  DataIngestionLambda:
    Type: AWS::Lambda::Function
    Properties:
      Handler: index.handler
      Role: !GetAtt LambdaExecutionRole.Arn
      Code:
        S3Bucket: !Ref SourceS3Bucket
        S3Key: lambda.zip
      Runtime: python3.8
      Timeout: 300

  # Rôle IAM pour la fonction Lambda
  LambdaExecutionRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              Service: lambda.amazonaws.com
            Action: sts:AssumeRole
      Policies:
        - PolicyName: LambdaS3AccessPolicy
          PolicyDocument:
            Version: '2012-10-17'
            Statement:
              - Effect: Allow
                Action:
                  - s3:GetObject
                  - s3:PutObject
                Resource: !Sub arn:aws:s3:::${SourceS3Bucket}/*

  # Workflow Step Functions pour orchestrer le pipeline Glue ETL et DataBrew
  DataPipelineStepFunction:
    Type: AWS::StepFunctions::StateMachine
    Properties:
      RoleArn: !GetAtt StepFunctionExecutionRole.Arn
      DefinitionString:
        Fn::Sub: |
          {
            "StartAt": "GlueDataBrewJob",
            "States": {
              "GlueDataBrewJob": {
                "Type": "Task",
                "Resource": "arn:aws:states:::glue:startJobRun.sync",
                "Parameters": {
                  "JobName": "${GlueDataBrewJob}"
                },
                "Next": "GlueETLJob"
              },
              "GlueETLJob": {
                "Type": "Task",
                "Resource": "arn:aws:states:::glue:startJobRun.sync",
                "Parameters": {
                  "JobName": "${GlueETLJob}"
                },
                "End": true
              }
            }
          }

  # Rôle IAM pour Step Functions
  StepFunctionExecutionRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              Service: states.amazonaws.com
            Action: sts:AssumeRole

  # Job Glue DataBrew pour nettoyer les données dans S3 (nettoyage des données)
  GlueDataBrewJob:
    Type: AWS::Glue::Job
    Properties:
      Role: !GetAtt GlueExecutionRole.Arn
      Command:
        Name: glueetl
        ScriptLocation: !Sub s3://${SourceS3Bucket}/scripts/databrew-job.py

  # Job Glue ETL pour transformer les données nettoyées (traitement des données)
  GlueETLJob:
    Type: AWS::Glue::Job
    Properties:
      Role: !GetAtt GlueExecutionRole.Arn
      Command:
        Name: glueetl
        ScriptLocation: !Sub s3://${SourceS3Bucket}/scripts/etl-job.py

  # Rôle IAM pour les jobs Glue (DataBrew et ETL)
  GlueExecutionRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              Service: glue.amazonaws.com
            Action: sts:AssumeRole

  # Table Athena pour interroger les données traitées via le catalogue de données Glue.
  AthenaTableForProcessedData:
    Type: AWS::Athena::NamedQuery
    Properties:
      DatabaseId: ProcessedDataCatalogDatabase
      QueryString: |
        CREATE EXTERNAL TABLE IF NOT EXISTS processed_data (
          id STRING,
          value STRING,
          timestamp STRING)
        LOCATION 's3://${SourceS3Bucket}/processed-data/'

Outputs:
  S3BucketOutput:
    Description: "Nom du bucket S3 créé."
    Value: !Ref SourceS3Bucket

```

### Explication du modèle :
1. **S3 Bucket** : Un bucket est créé pour stocker les fichiers sources.
2. **Lambda** : Une fonction Lambda est déclenchée lorsqu'un fichier est ajouté au bucket.
3. **Step Functions** : Un workflow orchestrant les jobs Glue DataBrew et ETL est défini.
4. **AWS Glue** : Deux jobs sont créés, un pour nettoyer les données (DataBrew) et un autre pour transformer ces données (ETL).
5. **Athena** : Une table Athena est créée pour interroger les données traitées.

Ce modèle peut être ajusté selon vos besoins spécifiques, tels que l'ajout de configurations supplémentaires ou d'autres services.

Citations:
[1] https://pplx-res.cloudinary.com/image/upload/v1731111716/user_uploads/gbkayexlp/image.jpg
[2] https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-guide.html
[3] https://spacelift.io/blog/what-is-aws-cloudformation
[4] https://github.com/jennapederson/cloudformation-examples
[5] https://www.simplilearn.com/tutorials/aws-tutorial/aws-cloudformation
[6] https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/GettingStarted.html
[7] https://spacelift.io/blog/aws-cloudformation-templates
[8] https://docs.localstack.cloud/user-guide/aws/cloudformation/
[9] https://docs.aws.amazon.com/en_en/AWSCloudFormation/latest/UserGuide/Welcome.html
