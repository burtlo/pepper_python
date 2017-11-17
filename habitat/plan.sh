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

  #
  # The application exists as a single file in the directory. A real application
  # would likely a single app directory or a few directories.

  app_dir=$pkg_prefix/app
  mkdir $app_dir
  cp index.py $app_dir/
  cp requirements.txt $app_dir

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

  cd $app_dir
  python -m venv .

  # It seemed the most straight-forward way to vendor all the libraries was to
  # define a virtual environment within the package. When reviewing it in my
  # head I think that should have been done at the root of the app to see if
  # the bin, lib and all the resulting tools would end up in the right place.
  # Any of those directories found would need to be described up above in the
  # plan definition.

  #
  # And this is where I need to explore more. I sourced this file so that when
  # I use pip next to install the dependencies it knows to store them locally.

  source bin/activate
  pip install -r requirements.txt

  # It seems like if I used the pip found in the build dependency `core/python`
  # those resulting dependencies would mutate the `core/python` package. I think
  # I found the flask binary was there and not in the package I'm currently
  # building.

}
