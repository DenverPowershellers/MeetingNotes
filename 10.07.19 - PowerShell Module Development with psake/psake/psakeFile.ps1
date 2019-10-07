task default -depends test

task hi {
    "running hi task"
}

task test -depends pester {
    "    running test task"
}

task pester -depends init {
    "    running pester task"
}

task init -depends clean {
    "    saying init task"
}

task clean {
    "    running clean task"
}