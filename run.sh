    #!/bin/bash
docker run --privileged=true --cap-add=ALL -it -v /home/user/Desktop/Docker/GloDroid/source:/aosp:z -v /lib/modules:/lib/modules:z -v /usr/src:/usr/src:z --restart unless-stopped ubuntu/aosp 
