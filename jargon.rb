 class Jargon < Formula
   desc "Manage iOS localized strings from Google Spreadsheet"
   homepage "https://github.com/dmiotti/jargon"
   url "https://github.com/dmiotti/jargon/releases/download/1.1.0/jargon"
   sha256 "2f20d8f74f209cd4b4d1bef49d945d8cc23ed5def522b5a4900d07ec45a58216"
   head "https://github.com/dmiotti/jargon.git"

   def install
     bin.install "jargon"
   end

   test do
     system "#{bin}/jargon", "myProject", "15WlWL5Dz40j0ckCPQI0an52IybJn3uSBQehYEo9IQWw"
   end
 end
