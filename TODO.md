-	move the `test_boxes` hash out of the vagrantfile into a json or yaml
    doc so that other tools can use it more easily.
-	`para-vagrant.sh` should read list of boxes (from json file, see above)
    instead of relying on hard-coded list of boxes in the script.
-	(bug) `para-vagrant.sh` failure and success counter reports '1' even if there
     are 0.
