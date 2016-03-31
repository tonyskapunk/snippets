# Make sure .Xresources is loaded
xrdb -merge ~/.Xresources

# Do it faster
export LC_ALL=C

# Call fluxbox
exec startfluxbox
