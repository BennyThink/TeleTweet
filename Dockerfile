FROM python:3.11-alpine as builder

RUN apk update && apk add --no-cache tzdata git
ADD requirements.txt /tmp/
RUN pip3 install --user -r /tmp/requirements.txt && rm /tmp/requirements.txt



FROM python:3.10-alpine

COPY --from=builder /root/.local /usr/local
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY . /TeleTweet

ENV TZ=Asia/Shanghai
WORKDIR /TeleTweet/teletweet
CMD ["python", "tweetbot.py"]
