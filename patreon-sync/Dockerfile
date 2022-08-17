FROM python:3
RUN python3 -m pip install --upgrade pip setuptools wheel && python3 -m pip install -U gallery-dl
COPY gallery-dl.conf /etc/gallery-dl.conf
# This is insecure as the cookies will be hardcoded into the image(s). It should be reworked to be provided at runtime.
COPY cookies-patreon-com.txt cookies-patreon-com.txt
# Actual
CMD [ "gallery-dl", "https://www.patreon.com/the_griffons_saddlebag/posts?filters[tag]=Art" ]
# Options
#CMD [ "gallery-dl", "-K", "https://www.patreon.com/the_griffons_saddlebag/posts?filters[tag]=Art" ]
# Reproduceable Example
#CMD [ "gallery-dl", "https://www.patreon.com/posts/alcoholock-69967057" ]
