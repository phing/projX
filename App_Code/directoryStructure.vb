Imports Microsoft.VisualBasic
Imports System.IO



Public Class DirectoryStructure
		Public Const dirRoot As String = "\\drserver\Dev\Projects"
    Public Const crossclient As String = "!Common"
    Private clientDB As mailingtypesDataContext

    Public Sub New()
        clientDB = New mailingtypesDataContext
    End Sub

    'Public Sub newProject(ByVal client As String, ByVal projtypeid As Integer, ByVal projname As String)



    'End Sub

    Public Sub check_n_make_client_dir(ByVal cid_email As Integer)
        createDirIfNotExists(Path.Combine(DirectoryStructure.dirRoot, getClientNameDevPath(cid_email)))
    End Sub

    Public Sub check_n_make_proj_types_dirs(ByVal cid_email As Integer)
        check_n_make_client_dir(cid_email)
        Dim ptypes = From arec In clientDB.project_types _
                     Select arec.projtype_dir

        For Each projtypedir In ptypes
            createDirIfNotExists(Path.Combine(Path.Combine(DirectoryStructure.dirRoot, getClientNameDevPath(cid_email)), projtypedir.ToString))
        Next
    End Sub

    Public Sub createDirIfNotExists(ByVal dirPath As String)
        If Not Directory.Exists(dirPath) Then
            Directory.CreateDirectory(dirPath)
        End If
    End Sub

    Private Sub createEfile(ByVal path As String)
        Dim file As System.IO.FileStream
        file = System.IO.File.Create(path)
    End Sub


    Public Sub createProjDirectory(ByVal client As String, ByVal cid_email As Integer, ByVal projtypeid As Integer, ByVal projname As String)
        check_n_make_proj_types_dirs(cid_email)

        Dim pnamedir = getProjPath(cid_email, projtypeid, projname)



        createDirIfNotExists(pnamedir)
        'createEfile(pnamedir & pnamedir & ".txt")

        Dim subprojdirs As List(Of String) = New List(Of String)
        subprojdirs.Add("canvases")
        subprojdirs.Add("comps")
        subprojdirs.Add("resources")


        For Each subd In subprojdirs
            'archive
            Dim subpath = Path.Combine(pnamedir, subd.ToString)
            createDirIfNotExists(subpath)
            createDirIfNotExists(Path.Combine(subpath, "archive"))
        Next


        If projtypeid = 4 Then  ' web project
            ' need to add html dir

            Dim htmlpath = Path.Combine(pnamedir, "html")

            createDirIfNotExists(htmlpath)
            createDirIfNotExists(Path.Combine(htmlpath, "images"))
            createDirIfNotExists(Path.Combine(htmlpath, "js"))
            createDirIfNotExists(Path.Combine(htmlpath, "styles"))

        End If

        If projtypeid = 2 Then ' if print
            Dim comppath = Path.Combine(pnamedir, "comps")
            createDirIfNotExists(Path.Combine(comppath, "comps - hi res"))
            createDirIfNotExists(Path.Combine(comppath, "comps - lo res"))
            createDirIfNotExists(Path.Combine(comppath, "comps - lo res\archive"))
            createDirIfNotExists(Path.Combine(comppath, "comps - hi res\archive"))
        End If


        If projtypeid = 6 Then ' slideshow
            Dim comppath = Path.Combine(pnamedir, "comps")
            createDirIfNotExists(Path.Combine(comppath, "comps - full"))
            createDirIfNotExists(Path.Combine(comppath, "comps - comps - slide only"))
            createDirIfNotExists(Path.Combine(comppath, "comps - full\archive"))
            createDirIfNotExists(Path.Combine(comppath, "comps - comps - slide only\archive"))
        End If



        If projtypeid = 0 Then  ' email project
            Dim htmlpath = Path.Combine(pnamedir, "html")
            createDirIfNotExists(htmlpath)
            createDirIfNotExists(Path.Combine(htmlpath, "images"))
        End If


    End Sub

    Public Function getClientNameDevPath(ByVal cid_email As Integer) As String
                Dim clientNameDir As String = (From arec In clientDB.clients_devs _
                                    Where arec.cid_email = cid_email _
                                    Select arec.dev_directory_pathname).FirstOrDefault

        If clientNameDir IsNot Nothing Then
            Return clientNameDir
        Else
            Return "UnknownClientPath"
        End If

    End Function

    Public Function getProjPath(ByVal cid_email As String, ByVal projtypeid As String, ByVal projname As String) As String
        If cid_email > 0 And Len(projname) > 0 And Len(projtypeid.ToString) > 0 Then

            Dim ptypedir = (From arec In clientDB.project_types _
                        Where arec.projtypeid = projtypeid _
                        Select arec.projtype_dir).FirstOrDefault
            Dim cpath As String = getClientNameDevPath(cid_email)
            Dim pdir As String = Path.Combine(Path.Combine(dirRoot, cpath), ptypedir.ToString)
            Dim pnamedir = Path.Combine(pdir, projname)
            Return pnamedir
        Else
            Return ""
        End If
    End Function


End Class
