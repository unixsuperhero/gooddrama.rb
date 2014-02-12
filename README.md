
# Download Video Files from GoodDrama.net

This was created for personal use.  Pass the script the URL of an episode on
GoodDrama.net and it will start downloading all the parts of the episode using
your default browser.

For example:

    $> ./gooddrama.rb 'http://www.gooddrama.net/japanese-drama/boku-no-imoto-episode-11'

    # This found the following 3 parts and downloaded them for me with Chrome:
    #
    #   "http://gateway2.play44.net/videos/B/boku_no_imoto_-_11_part_1.flv?st=hSdVtHeCZxEM_PJwrZE5Gg&e=1392189729&server=videobug"
    #   "http://gateway2.play44.net/videos/B/boku_no_imoto_-_11_part_2.flv?st=YtBEf3qLP4DGumjmPvx9Wg&e=1392189730&server=videobug"
    #   "http://gateway2.play44.net/videos/B/boku_no_imoto_-_11_part_3.flv?st=uk2tbjKn-O-QhaKUu4mJoA&e=1392189731&server=videobug"
    #

# Note

I did not write this with any intention of demonstrating good coding style.
Some aspects are inefficient.  However, it is a great little script.  I
accomplished my goal in less than 5min.

Also, this won't work for every series.  Which site hosts the files is
important.  I am assuming that the first mirror uses the embed.php player.
As I encounter episodes that aren't compatible I will update the script
accordingly.
