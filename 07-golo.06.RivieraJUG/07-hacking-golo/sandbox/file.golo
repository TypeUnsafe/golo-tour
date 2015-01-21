module nandou.File

function currentWorkingDirectory = -> java.io.File( "." ):getCanonicalPath()

function fileExists = |path| -> java.io.File(path):exists()

function fileName = |path| -> java.io.File(path):getName()