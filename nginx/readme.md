Compress video:
ffmpeg -i parapent.mp4 -vcodec libx264 -crf 32 -preset slower -acodec aac -b:a 96k parapent_small.mp4
ffmpeg -i parapent.mp4 -vcodec libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p -preset slow -b:v 800k -an parapent_mobile.mp4
ffmpeg -i parapent.mp4 -vf scale=640:-2 -b:v 600k -an parapent_mobile_low.mp4
ffmpeg -i parapent.mp4 -vcodec libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p -preset slow -b:v 1500k -an parapent_mobile.mp4
ffmpeg -i parapent.mp4 -vf scale=1280:-2 -b:v 1500k -preset slow -an parapent_mobile_720p.mp4
ffmpeg -i parapent.mp4 -c:v libvpx-vp9 -b:v 1500k -c:a libopus parapent_vp9.webm



Permissions:
/var/www/html
sudo chown www-data:www-data /var/www/html/parapent_mobile.mp4
sudo chmod 755 /var/www/html
sudo systemctl reload nginx



Files inside:
sudo find /var/www/html -type f -exec chmod 644 {} \;
sudo find /var/www/html -type f -exec chown www-data:www-data {} \;

sudo vim /etc/nginx/sites-available/default
