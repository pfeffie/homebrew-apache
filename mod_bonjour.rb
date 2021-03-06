require 'formula'

class ModBonjour < Formula
  homepage 'http://www.opensource.apple.com/source/apache_mod_bonjour/apache_mod_bonjour-15/'
  url 'http://www.opensource.apple.com/tarballs/apache_mod_bonjour/apache_mod_bonjour-15.tar.gz'
  sha1 '1b9574e4ba391c87f19de18bf6295b55cf298c89'
  version '1.5'

  depends_on :xcode

  def install
    system "make install INSTALLDIR2=#{libexec}"
  end

  def caveats
    <<-EOS.undent
    NOTE: If you're having installation problems relating to a missing `cc` compiler and
    `OSX10.8.xctoolchain` or `OSX10.9.xctoolchain`, read the "Troubleshooting" section
    of https://github.com/Homebrew/homebrew-apache

    You're not done yet!
    To enable mod_bonjour in Apache, add the following to httpd.conf and restart Apache:
        LoadModule bonjour_module #{libexec}/mod_bonjour.so

    If you are running OS X Lion 10.7 or earlier, you will need to comment out the line
    in httpd.conf for the built-in mod_bonjour.so module and use only this one.

    Add the following to your virtual host conf files to advertise them on bonjour. The
    last number is whatever port the virtual host is listening on.

        <IfModule bonjour_module>
            RegisterResource "Site Title" / 80
        </IfModule>
    EOS
  end
end
