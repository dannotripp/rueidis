module github.com/dannotripp/rueidis/rueidisprob

go 1.22.0

replace github.com/dannotripp/rueidis => ../

require (
	github.com/dannotripp/rueidis v0.0.0-20250303054856-527df373e22b
	github.com/twmb/murmur3 v1.1.8
)

require golang.org/x/sys v0.30.0 // indirect
