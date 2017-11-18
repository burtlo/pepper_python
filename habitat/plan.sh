pkg_name=pepper_python
pkg_origin=franklinwebber
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_deps=(core/python)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  return 0
}

do_install() {

  #
  # The application exists as a single file in the directory. A real application
  # would likely a single app directory or a few directories.

  app_dir=$pkg_prefix/app
  mkdir $app_dir
  cp index.py $app_dir/
  cp requirements.txt $app_dir/

  # It had a single requirement on Flask. Which of course has it's own reqs.
  #
  # NOTE: I opted to store dependencies in a requirements.txt for no other reason than
  # it was the first way that worked. I have seen one project now that uses a
  # setup.py
  #
  # I imagine both have their advantages. requirements.txt seems to benefit
  # in the lack of complexity. Though it irks me that that it has the txt
  # extension when there is obviously a particular format style.

  #
  # Now with the application copied into in the package I needed to get all of
  # its dependencies vendored into the package as well.

  cd $pkg_prefix
  python -m venv .

  # It seemed the most straight-forward way to vendor all the libraries was to
  # define a virtual environment within the package.
  #
  # I do this in the package root to create a `bin`, `lib`, and `include` which
  # are included in the package definition. This does not put the dependencies
  # on the path. However, if the dependencies were vendored, packaged in their
  # own Habitat package, then added as a dependency of this package it would
  # have all the tools on the path as one would expect.

  bin/pip install -r $app_dir/requirements.txt

  # It seems like if I used the pip found in the build dependency `core/python`
  # those resulting dependencies would mutate the `core/python` package -
  # installing them there. By using this vendored pip the dependencies will
  # be placed here in the `bin`, `lib`, and `include`.

}
