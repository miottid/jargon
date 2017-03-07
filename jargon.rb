 class Jargon < Formula
   desc "Manage iOS localized strings from Google Spreadsheet"
   homepage "https://github.com/dmiotti/jargon"
   url "https://github.com/dmiotti/jargon/releases/download/1.0.0/jargon"
   sha256 "ad316aec9315f436d461a10882d2581f063535f966a0dba507f46830903cb053"
   head "https://github.com/dmiotti/jargon.git"

   def install
     bin.install "jargon"
   end

   test do
     system "#{bin}/jargon", "myProject", "15WlWL5Dz40j0ckCPQI0an52IybJn3uSBQehYEo9IQWw"
   end
 end
