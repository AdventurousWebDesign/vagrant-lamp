Description
===========

Installs and configures PHP 5.3.

---

Requirements
============

Platform
--------

* Ubuntu

Cookbooks
---------

* build-essential
* xml
* mysql

---
Attributes
==========

The file also contains the following attribute types:

* platform specific locations and settings.
* source installation settings

---

Recipes
=======

default
-------

Include the default recipe in a run list, to get `php`.  By default `php` is installed from packages but this can be changed by using the `install_method` attribute.
This recipe installs PHP from source.


License and Author
==================

Author:: Seth Chisamore (<schisamo@opscode.com>)
Author:: Joshua Timberman (<joshua@opscode.com>)
Author:: Cameron Hurd (<me@cameronhurd.com>)

Copyright:: 2011, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
