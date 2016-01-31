#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: php
# Attribute:: default
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Compiled Without the --with-gmp flag (GNU Multiple Precision) (http://php.net/manual/en/book.gmp.php)
# Compile Without the --with-libevent-dir (Not a feature in php5.3)

default['php']['conf_dir']      = '/etc/php53/cli'
default['php']['ext_conf_dir']  = '/etc/php53/conf.d'
default['php']['fpm_user']      = 'www-data'
default['php']['fpm_group']     = 'www-data'

default['php']['url']        = 'http://in1.php.net/distributions'
default['php']['version']    = '5.3.29'
default['php']['checksum']   = 'c4e1cf6972b2a9c7f2777a18497d83bf713cdbecabb65d3ff62ba441aebb0091'
default['php']['prefix_dir'] = '/usr/share/php53'
default['php']['bin_dir']    = '/usr/bin/php53'
default['php']['inc_dir']    = '/usr/include/php53'
default['php']['apache_dir'] = '/etc/php53/apache2'
default['php']['cgi_dir']    = '/usr/lib/cgi-bin/php53'
default['php']['cgi_path']   = '/usr/lib/cgi-bin/php53/php53-cgi'

default['php']['configure_options'] = %W{--prefix=#{php['prefix_dir']}
                                          --datadir=#{php['prefix_dir']}
                                          --mandir=/usr/share/man
                                          --bindir=#{php['bin_dir']}
                                          --includedir=#{php['inc_dir']}
                                          --sysconfdir=#{php['apache_dir']}
                                          --with-libdir=lib
                                          --with-config-file-path=#{php['apache_dir']}
                                          --with-config-file-scan-dir=#{php['ext_conf_dir']}
                                          --enable-bcmath
                                          --with-curl=shared,/usr
                                          --with-mcrypt=shared,/usr
                                          --with-pear
                                          --enable-cli
                                          --enable-session
                                          --with-zlib
                                          --with-kerberos
                                          --with-bz2
                                          --enable-ftp
                                          --enable-zip
                                          --enable-exif
                                          --enable-gd-native-ttf
                                          --with-gd
                                          --with-gettext
                                          --with-mhash
                                          --with-iconv
                                          --with-imap
                                          --with-imap-ssl
                                          --enable-sockets
                                          --enable-soap
                                          --enable-libxml
                                          --with-xmlrpc
                                          --with-mcrypt
                                          --enable-mbstring
                                          --with-t1lib
                                          --enable-shared
                                          --with-mysql
                                          --enable-xml
                                          --enable-simplexml
                                          --enable-filter
                                          --enable-inline-optimization
                                          --with-jpeg-dir
                                          --with-png-dir
                                          --with-zlib
                                          --with-bz2
                                          --with-curl
                                          --enable-exif
                                          --with-pic
                                          --disable-rpath
                                          --disable-static
                                          --enable-shared
                                          --enable-cgi
                                          --with-gnu-ld
                                          --with-mysql-sock}
