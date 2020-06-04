ARG DOTNETCORE_VESRION=3.1
FROM mcr.microsoft.com/dotnet/core/sdk:${DOTNETCORE_VESRION} AS build

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# 非対話型に切り替えることで警告を回避します。
ENV DEBIAN_FRONTEND=noninteractive

# ソースをコンテナにコピー
WORKDIR /src
COPY . .

# ソースをビルド
WORKDIR /src/ServerApp/KpiReport
RUN dotnet publish "KpiReport.csproj" -c Release -o /app/publish



# 実行用コンテナ。SDKではなく実行に必要なもののみを保持したイメージを利用。
FROM mcr.microsoft.com/dotnet/core/aspnet:${DOTNETCORE_VESRION} AS runtime

# ポート開放
EXPOSE 8080

# Timezoneを変更(Debianの場合)
RUN rm /etc/localtime && echo Asia/Tokyo > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# localeの変更
RUN apt update && apt-get install -y locales && locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8


# ホスト部分をlocalhostにすると「Unable to bind to http://localhost:80 on the IPv6 loopback interface: 'Cannot assign requested address'」というエラーになる。
# GAE上で動作する場合、8080ポートの指定は必須。
# https://cloud.google.com/appengine/docs/flexible/custom-runtimes/build#code
ENV ASPNETCORE_URLS http://0.0.0.0:8080


# buildコンテナから発行したファイルをコピー
WORKDIR /app
COPY --from=build /app/publish ./

ENTRYPOINT ["dotnet", "/app/KpiReport.dll"]