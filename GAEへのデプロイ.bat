cd %~dp0

rem  --no-promoteを指定すると、自動で新バージョンに切り替わらなくなる。切り替え前に動作を確認したい場合に利用。 
rem  切り替える場合は、GCPポータルの「App Engine」→「バージョン」で対象サービスを選び、「トラフィックを分割」で最新バージョンへのトラフィックを100%にする。 

gcloud app deploy --project GCPのプロジェクト名 --quiet --no-promote app.yaml

pause
