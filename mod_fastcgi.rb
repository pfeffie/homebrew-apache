require 'formula'

class ModFastcgi < Formula
  url 'http://www.fastcgi.com/dist/mod_fastcgi-2.4.6.tar.gz'
  homepage 'http://www.fastcgi.com/'
  sha1 '69c56548bf97040a61903b32679fe3e3b7d3c2d4'

  def install
    target_arch = MacOS.prefer_64_bit? ? "x86_64" : "i386"
    system "cp Makefile.AP2 Makefile"
    ENV.append_to_cflags "-mmacosx-version-min=#{MACOS_VERSION}"
    ENV.append_to_cflags "-isysroot #{MacOS.sdk_path}"
    ENV.append_to_cflags "-arch #{target_arch}"
    system "make", "top_dir=/usr/share/httpd"
    libexec.install '.libs/mod_fastcgi.so'
  end

  def caveats; <<-EOS.undent
    NOTE: If you're having installation problems relating to a missing `cc` compiler and
    `OSX10.8.xctoolchain` or `OSX10.9.xctoolchain`, read the "Troubleshooting" section
    of https://github.com/Homebrew/homebrew-apache

    You must manually edit /etc/apache2/httpd.conf to contain:
      LoadModule fastcgi_module #{libexec}/mod_fastcgi.so

    Upon restarting Apache, you should see the following message in the error log:
      [notice] FastCGI: process manager initialized
    EOS
  end

end
