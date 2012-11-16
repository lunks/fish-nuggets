function rvm -d 'Ruby enVironment Manager'
  # run RVM and capture the resulting environment
  set -l env_file (mktemp -t rvm.fish.XXXXXXXXXX)
  bash -c 'source ~/.rvm/scripts/rvm; cd .; rvm "$@"; status=$?; env > "$0"; exit $status' $env_file $argv

  # apply rvm_* , *PATH , GEM_HOME and RUBY_VERSION variables from the captured environment
  and eval (grep '^rvm\|^[^=]*PATH\|^GEM_HOME\|^RUBY_VERSION' $env_file | sed '/^[^=]*PATH/y/:/ /; s/^/set -xg /; s/=/ /; s/$/ ;/; s/(//; s/)//')
  # clean up
  rm -f $env_file
end
