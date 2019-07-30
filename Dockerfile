# Use an official Python runtime as a parent image
FROM python:3.7-slim

# Set the working directory to /app
WORKDIR /app

RUN apt update && apt upgrade -y && apt install build-essential \
                                    mime-support python3-dev -y

# Make port 80(app) and 81(stats) available to the world outside this container
EXPOSE 80
EXPOSE 81

# Install UWSGI
RUN pip install uwsgi

# Add dependencies file to /app
ADD ./home /app/home
ADD ./mysite /app/mysite
ADD ./manage.py /app
ADD ./requirements.txt /app
ADD ./startup.sh /app
ADD ./wsgi.ini /app

# Install dependencies
RUN pip install -r requirements.txt

# Run UWSGI
CMD ["./startup.sh"]
