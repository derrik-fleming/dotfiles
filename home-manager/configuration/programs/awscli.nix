{ ... }:

{
  programs.awscli = {
    enable = true;
    settings = {
      "profile callbox-personal" = {
        sso_session = "spindance-sso";
        sso_account_id = "518431045260";
        sso_role_name = "AdministratorAccess";
        region = "us-east-1";
        credential_process = "aws configure export-credentials --profile callbox-personal";
      };

      "profile callbox-staging" = {
        sso_session = "spindance-sso";
        sso_account_id = "282509448206";
        sso_role_name = "PowerUserAccess";
        region = "us-east-1";
        credential_process = "aws configure export-credentials --profile callbox-staging";
      };

      "profile callbox-production" = {
        sso_session = "spindance-sso";
        sso_account_id = "164951669681";
        sso_role_name = "ReadOnlyAccess";
        region = "us-east-1";
        credential_process = "aws configure export-credentials --profile callbox-production";
      };

      "sso-session spindance-sso" = {
        sso_start_url = "https://spindance.awsapps.com/start#/";
        sso_region = "us-east-2";
        sso_registration_scopes = "sso:account:access";
      };

      "profile gentex-sandbox-sso" = {
        sso_session = "gentex-sso";
        sso_account_id = "458146294706";
        sso_role_name = "ExtendedAdministratorAccess";
        region = "us-east-2";
        credential_process = "aws configure export-credentials --profile gentex-sandbox";
      };

      "profile gentex-web-sso" = {
        sso_session = "gentex-sso";
        sso_account_id = "511280261655";
        sso_role_name = "ExtendedAdministratorAccess";
        region = "us-east-2";
        credential_process = "aws configure export-credentials --profile gentex-sandbox";
      };

      "sso-session gentex-sso" = {
        sso_start_url = "https://gentex-sso.awsapps.com/start#/";
        sso_region = "us-east-2";
        sso_registration_scopes = "sso:account:access";
      };

      "profile gentex-sandbox" = {
        region = "us-east-2";
        output = "json";
      };

      "profile siemens-dse-dev" = {
        region = "eu-west-1";
        output = "json";
      };

      "profile siemens-dse-xfer" = {
        region = "eu-west-1";
        output = "json";
      };
    };
  };
}
