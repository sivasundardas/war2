FROM tomcat:9-jre9
COPY ./target/war2.war /usr/local/tomcat/webapps/