task default -depends test

task test -depends pester {
    "    running test task"
}

task pester {
    "    running pester task"
}

task hi {
    "    saying hi"
}