#=============================
# rbenv
#=============================
if [ -d ${HOME}/.rbenv  ] ; then
  PATH=${HOME}/.rbenv/bin:${PATH}
  PATH=${HOME}/.rbenv/shims:${PATH}
  export PATH
  eval "$(rbenv init -)"
fi
