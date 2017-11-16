pkg_name=pepper_python
pkg_origin=franklinwebber
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_deps=(core/python)

do_build() {
  return 0
}

do_install() {
  app_dir=$pkg_prefix/app
  mkdir $app_dir

  cp index.py $app_dir/
  cp requirements.txt $app_dir
  cd $app_dir
  python -m venv .
  source bin/activate
  pip install -r requirements.txt
}