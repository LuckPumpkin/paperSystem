/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2016/5/31 17:23:02                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Achievement') and o.name = 'FK_ACHIEVEM_PROJECT_A_PROJECT')
alter table Achievement
   drop constraint FK_ACHIEVEM_PROJECT_A_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Branch') and o.name = 'FK_BRANCH_PARENTDEP_BRANCH')
alter table Branch
   drop constraint FK_BRANCH_PARENTDEP_BRANCH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CommentGroup') and o.name = 'FK_COMMENTG_DEPARTMEN_BRANCH')
alter table CommentGroup
   drop constraint FK_COMMENTG_DEPARTMEN_BRANCH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CommentGroup') and o.name = 'FK_COMMENTG_SCHEDULIN_SCHEDULI')
alter table CommentGroup
   drop constraint FK_COMMENTG_SCHEDULIN_SCHEDULI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CommentGroup_Teacher') and o.name = 'FK_COMMENTG_COMMENTGR_COMMENTG')
alter table CommentGroup_Teacher
   drop constraint FK_COMMENTG_COMMENTGR_COMMENTG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CommentGroup_Teacher') and o.name = 'FK_COMMENTG_COMMENTGR_TEACHER')
alter table CommentGroup_Teacher
   drop constraint FK_COMMENTG_COMMENTGR_TEACHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CommentsGroup_Project') and o.name = 'FK_COMMENTS_COMMENTSG_COMMENTG')
alter table CommentsGroup_Project
   drop constraint FK_COMMENTS_COMMENTSG_COMMENTG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CommentsGroup_Project') and o.name = 'FK_COMMENTS_PROJECT_C_PROJECT')
alter table CommentsGroup_Project
   drop constraint FK_COMMENTS_PROJECT_C_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Document') and o.name = 'FK_DOCUMENT_DOCUMENTC_DOCUMENT')
alter table Document
   drop constraint FK_DOCUMENT_DOCUMENTC_DOCUMENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Document') and o.name = 'FK_DOCUMENT_PROJECT_D_PROJECT')
alter table Document
   drop constraint FK_DOCUMENT_PROJECT_D_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Expense') and o.name = 'FK_EXPENSE_PROJECT_E_PROJECT')
alter table Expense
   drop constraint FK_EXPENSE_PROJECT_E_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ExpenseAttachment') and o.name = 'FK_EXPENSEA_EXPENSE_E_EXPENSE')
alter table ExpenseAttachment
   drop constraint FK_EXPENSEA_EXPENSE_E_EXPENSE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ExpenseDetail') and o.name = 'FK_EXPENSED_EXPENSE_E_EXPENSE')
alter table ExpenseDetail
   drop constraint FK_EXPENSED_EXPENSE_E_EXPENSE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ExpertEvaluationResults') and o.name = 'FK_EXPERTEV_COMMENTSG_COMMENTG')
alter table ExpertEvaluationResults
   drop constraint FK_EXPERTEV_COMMENTSG_COMMENTG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ExpertEvaluationResults') and o.name = 'FK_EXPERTEV_PROJECT_E_PROJECT')
alter table ExpertEvaluationResults
   drop constraint FK_EXPERTEV_PROJECT_E_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ExpertEvaluationResults') and o.name = 'FK_EXPERTEV_TEACHER_E_TEACHER')
alter table ExpertEvaluationResults
   drop constraint FK_EXPERTEV_TEACHER_E_TEACHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FirstClassDiscipline') and o.name = 'FK_FIRSTCLA_FIRSTCLAS_DISCIPLI')
alter table FirstClassDiscipline
   drop constraint FK_FIRSTCLA_FIRSTCLAS_DISCIPLI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GuideTeacher') and o.name = 'FK_GUIDETEA_PROJECT_G_PROJECT')
alter table GuideTeacher
   drop constraint FK_GUIDETEA_PROJECT_G_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GuideTeacher') and o.name = 'FK_GUIDETEA_TEACHER_G_TEACHER')
alter table GuideTeacher
   drop constraint FK_GUIDETEA_TEACHER_G_TEACHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Project') and o.name = 'FK_PROJECT_PROJECTRA_PROJECTR')
alter table Project
   drop constraint FK_PROJECT_PROJECTRA_PROJECTR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Project') and o.name = 'FK_PROJECT_STATE_PRO_STATE')
alter table Project
   drop constraint FK_PROJECT_STATE_PRO_STATE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ProjectRank_Action') and o.name = 'FK_PROJECTR_PROJECTRA_PROJECTR')
alter table ProjectRank_Action
   drop constraint FK_PROJECTR_PROJECTRA_PROJECTR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ProjectRank_Action') and o.name = 'FK_PROJECTR_STATE_POS_STATE')
alter table ProjectRank_Action
   drop constraint FK_PROJECTR_STATE_POS_STATE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ProjectRank_Action') and o.name = 'FK_PROJECTR_STATE_PRE_STATE')
alter table ProjectRank_Action
   drop constraint FK_PROJECTR_STATE_PRE_STATE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ProjectRank_Action') and o.name = 'FK_PROJECTR_TRIGGERAC_ACTION')
alter table ProjectRank_Action
   drop constraint FK_PROJECTR_TRIGGERAC_ACTION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Student') and o.name = 'FK_STUDENT_USER_STUD_USER')
alter table Student
   drop constraint FK_STUDENT_USER_STUD_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Teacher') and o.name = 'FK_TEACHER_USER_STUD_USER')
alter table Teacher
   drop constraint FK_TEACHER_USER_STUD_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TeamMember') and o.name = 'FK_TEAMMEMB_PROJECT_T_PROJECT')
alter table TeamMember
   drop constraint FK_TEAMMEMB_PROJECT_T_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TeamMember') and o.name = 'FK_TEAMMEMB_STUDENT_T_STUDENT')
alter table TeamMember
   drop constraint FK_TEAMMEMB_STUDENT_T_STUDENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"User"') and o.name = 'FK_USER_DEPARTMEN_BRANCH')
alter table "User"
   drop constraint FK_USER_DEPARTMEN_BRANCH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('UsersInRoles') and o.name = 'FK_USERSINR_ROLES_USE_ROLES')
alter table UsersInRoles
   drop constraint FK_USERSINR_ROLES_USE_ROLES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('UsersInRoles') and o.name = 'FK_USERSINR_USER_ROLE_USER')
alter table UsersInRoles
   drop constraint FK_USERSINR_USER_ROLE_USER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Achievement')
            and   name  = 'Project_Achievement_FK'
            and   indid > 0
            and   indid < 255)
   drop index Achievement.Project_Achievement_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Achievement')
            and   type = 'U')
   drop table Achievement
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Action')
            and   type = 'U')
   drop table Action
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Branch')
            and   name  = 'ParentDept_ChildDept_FK'
            and   indid > 0
            and   indid < 255)
   drop index Branch.ParentDept_ChildDept_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Branch')
            and   type = 'U')
   drop table Branch
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CommentGroup')
            and   name  = 'Department_CommentsGroup_FK'
            and   indid > 0
            and   indid < 255)
   drop index CommentGroup.Department_CommentsGroup_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CommentGroup')
            and   name  = 'Scheduling_CommentsGroup_FK'
            and   indid > 0
            and   indid < 255)
   drop index CommentGroup.Scheduling_CommentsGroup_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CommentGroup')
            and   type = 'U')
   drop table CommentGroup
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CommentGroup_Teacher')
            and   name  = 'CommentGroup_Teacher_Teacher_FK'
            and   indid > 0
            and   indid < 255)
   drop index CommentGroup_Teacher.CommentGroup_Teacher_Teacher_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CommentGroup_Teacher')
            and   name  = 'CommentGroup_CommentGroup_Teacher_FK'
            and   indid > 0
            and   indid < 255)
   drop index CommentGroup_Teacher.CommentGroup_CommentGroup_Teacher_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CommentGroup_Teacher')
            and   type = 'U')
   drop table CommentGroup_Teacher
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CommentsGroup_Project')
            and   name  = 'Project_CommentsGroup_Project_FK'
            and   indid > 0
            and   indid < 255)
   drop index CommentsGroup_Project.Project_CommentsGroup_Project_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CommentsGroup_Project')
            and   name  = 'CommentsGroup_Project_CommentsGroup_FK'
            and   indid > 0
            and   indid < 255)
   drop index CommentsGroup_Project.CommentsGroup_Project_CommentsGroup_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CommentsGroup_Project')
            and   type = 'U')
   drop table CommentsGroup_Project
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DisciplineClass')
            and   type = 'U')
   drop table DisciplineClass
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Document')
            and   name  = 'Project_Document_FK'
            and   indid > 0
            and   indid < 255)
   drop index Document.Project_Document_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Document')
            and   name  = 'DocumentClass_Document_FK'
            and   indid > 0
            and   indid < 255)
   drop index Document.DocumentClass_Document_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Document')
            and   type = 'U')
   drop table Document
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DocumentClass')
            and   type = 'U')
   drop table DocumentClass
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Expense')
            and   name  = 'Project_Expense_FK'
            and   indid > 0
            and   indid < 255)
   drop index Expense.Project_Expense_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Expense')
            and   type = 'U')
   drop table Expense
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ExpenseAttachment')
            and   name  = 'Expense_ExpenseAttachment_FK'
            and   indid > 0
            and   indid < 255)
   drop index ExpenseAttachment.Expense_ExpenseAttachment_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ExpenseAttachment')
            and   type = 'U')
   drop table ExpenseAttachment
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ExpenseDetail')
            and   name  = 'Expense_ExpenseDetail_FK'
            and   indid > 0
            and   indid < 255)
   drop index ExpenseDetail.Expense_ExpenseDetail_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ExpenseDetail')
            and   type = 'U')
   drop table ExpenseDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ExpenseType')
            and   type = 'U')
   drop table ExpenseType
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ExpertEvaluationResults')
            and   name  = 'Teacher_ExpertEvaluationResults_FK'
            and   indid > 0
            and   indid < 255)
   drop index ExpertEvaluationResults.Teacher_ExpertEvaluationResults_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ExpertEvaluationResults')
            and   name  = 'Project_ExpertEvaluationResults_FK'
            and   indid > 0
            and   indid < 255)
   drop index ExpertEvaluationResults.Project_ExpertEvaluationResults_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ExpertEvaluationResults')
            and   name  = 'CommentsGroup_ExpertEvaluationResults_FK'
            and   indid > 0
            and   indid < 255)
   drop index ExpertEvaluationResults.CommentsGroup_ExpertEvaluationResults_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ExpertEvaluationResults')
            and   type = 'U')
   drop table ExpertEvaluationResults
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FirstClassDiscipline')
            and   type = 'U')
   drop table FirstClassDiscipline
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GuideTeacher')
            and   name  = 'Teacher_GuideTeacher_FK'
            and   indid > 0
            and   indid < 255)
   drop index GuideTeacher.Teacher_GuideTeacher_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GuideTeacher')
            and   name  = 'Project_GuideTeacher_FK'
            and   indid > 0
            and   indid < 255)
   drop index GuideTeacher.Project_GuideTeacher_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GuideTeacher')
            and   type = 'U')
   drop table GuideTeacher
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Project')
            and   name  = 'ProjectRank_Project_FK'
            and   indid > 0
            and   indid < 255)
   drop index Project.ProjectRank_Project_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Project')
            and   name  = 'State_Project_FK'
            and   indid > 0
            and   indid < 255)
   drop index Project.State_Project_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Project')
            and   type = 'U')
   drop table Project
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ProjectRank')
            and   type = 'U')
   drop table ProjectRank
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ProjectRank_Action')
            and   name  = 'ProjectRank_TriggerAction_ProjectRank_FK'
            and   indid > 0
            and   indid < 255)
   drop index ProjectRank_Action.ProjectRank_TriggerAction_ProjectRank_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ProjectRank_Action')
            and   name  = 'State_PreState_FK'
            and   indid > 0
            and   indid < 255)
   drop index ProjectRank_Action.State_PreState_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ProjectRank_Action')
            and   name  = 'TriggerAction_ProjectRank_TriggerAction_FK'
            and   indid > 0
            and   indid < 255)
   drop index ProjectRank_Action.TriggerAction_ProjectRank_TriggerAction_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ProjectRank_Action')
            and   name  = 'State_PostState_FK'
            and   indid > 0
            and   indid < 255)
   drop index ProjectRank_Action.State_PostState_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ProjectRank_Action')
            and   type = 'U')
   drop table ProjectRank_Action
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Roles')
            and   type = 'U')
   drop table Roles
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Scheduling')
            and   type = 'U')
   drop table Scheduling
go

if exists (select 1
            from  sysobjects
           where  id = object_id('State')
            and   type = 'U')
   drop table State
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Student')
            and   type = 'U')
   drop table Student
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Teacher')
            and   type = 'U')
   drop table Teacher
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TeamMember')
            and   name  = 'Student_TeamMember_FK'
            and   indid > 0
            and   indid < 255)
   drop index TeamMember.Student_TeamMember_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TeamMember')
            and   name  = 'Project_TeamMember_FK'
            and   indid > 0
            and   indid < 255)
   drop index TeamMember.Project_TeamMember_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TeamMember')
            and   type = 'U')
   drop table TeamMember
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"User"')
            and   name  = 'Department_UserCode_FK'
            and   indid > 0
            and   indid < 255)
   drop index "User".Department_UserCode_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"User"')
            and   type = 'U')
   drop table "User"
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('UsersInRoles')
            and   name  = 'Roles_Users_FK'
            and   indid > 0
            and   indid < 255)
   drop index UsersInRoles.Roles_Users_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('UsersInRoles')
            and   name  = 'User_Role_FK'
            and   indid > 0
            and   indid < 255)
   drop index UsersInRoles.User_Role_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('UsersInRoles')
            and   type = 'U')
   drop table UsersInRoles
go

/*==============================================================*/
/* Table: Achievement                                           */
/*==============================================================*/
create table Achievement (
   AchievementCode      int                  identity,
   InnerProjectID       nvarchar(40)         not null,
   Achievement          nvarchar(50)         not null,
   Path                 nvarchar(100)        null,
   AchievementClass     nvarchar(10)         null,
   IsFistAchieve        bit                  null,
   AchieveInstruction   text                 null,
   Remarks              text                 null,
   FirstAuthor          nvarchar(8)          null,
   constraint PK_ACHIEVEMENT primary key nonclustered (AchievementCode)
)
go

/*==============================================================*/
/* Index: Project_Achievement_FK                                */
/*==============================================================*/
create index Project_Achievement_FK on Achievement (
InnerProjectID ASC
)
go

/*==============================================================*/
/* Table: Action                                                */
/*==============================================================*/
create table Action (
   ActionID             int                  identity,
   ActionName           nvarchar(40)         null,
   ActionView           nvarchar(40)         null,
   constraint PK_ACTION primary key nonclustered (ActionID)
)
go

/*==============================================================*/
/* Table: Branch                                                */
/*==============================================================*/
create table Branch (
   BranchID             int                  identity,
   ParentBranchID       int                  null,
   BranchName           nvarchar(40)         null,
   HierarchyLevel       int                  null,
   FullPath             nvarchar(400)        null,
   OrderID              int                  null,
   DeleteMark           bit                  null default 0,
   constraint PK_BRANCH primary key nonclustered (BranchID)
)
go

/*==============================================================*/
/* Index: ParentDept_ChildDept_FK                               */
/*==============================================================*/
create index ParentDept_ChildDept_FK on Branch (
ParentBranchID ASC
)
go

/*==============================================================*/
/* Table: CommentGroup                                          */
/*==============================================================*/
create table CommentGroup (
   CommentsGroupCode    nvarchar(40)         not null,
   SchedulingCode       nvarchar(40)         not null,
   BranchID             int                  null,
   CommentClass         nvarchar(20)         null,
   ReplyPlace           text                 null,
   ReplyTime            datetime             null,
   CommentsNumId        nvarchar(40)         null,
   constraint PK_COMMENTGROUP primary key nonclustered (CommentsGroupCode)
)
go

/*==============================================================*/
/* Index: Scheduling_CommentsGroup_FK                           */
/*==============================================================*/
create index Scheduling_CommentsGroup_FK on CommentGroup (
SchedulingCode ASC
)
go

/*==============================================================*/
/* Index: Department_CommentsGroup_FK                           */
/*==============================================================*/
create index Department_CommentsGroup_FK on CommentGroup (
BranchID ASC
)
go

/*==============================================================*/
/* Table: CommentGroup_Teacher                                  */
/*==============================================================*/
create table CommentGroup_Teacher (
   CommentsGroupCode    nvarchar(40)         not null,
   UserCode             nvarchar(40)         not null,
   Master               bit                  null,
   constraint AK_PK_COMMENTSGROUPTE_COMMENTG unique (CommentsGroupCode, UserCode)
)
go

/*==============================================================*/
/* Index: CommentGroup_CommentGroup_Teacher_FK                  */
/*==============================================================*/
create index CommentGroup_CommentGroup_Teacher_FK on CommentGroup_Teacher (
CommentsGroupCode ASC
)
go

/*==============================================================*/
/* Index: CommentGroup_Teacher_Teacher_FK                       */
/*==============================================================*/
create index CommentGroup_Teacher_Teacher_FK on CommentGroup_Teacher (
UserCode ASC
)
go

/*==============================================================*/
/* Table: CommentsGroup_Project                                 */
/*==============================================================*/
create table CommentsGroup_Project (
   CommentProjectCode   nvarchar(40)         not null,
   CommentsGroupCode    nvarchar(40)         not null,
   InnerProjectID       nvarchar(40)         not null,
   constraint PK_COMMENTSGROUP_PROJECT primary key nonclustered (CommentProjectCode)
)
go

/*==============================================================*/
/* Index: CommentsGroup_Project_CommentsGroup_FK                */
/*==============================================================*/
create index CommentsGroup_Project_CommentsGroup_FK on CommentsGroup_Project (
CommentsGroupCode ASC
)
go

/*==============================================================*/
/* Index: Project_CommentsGroup_Project_FK                      */
/*==============================================================*/
create index Project_CommentsGroup_Project_FK on CommentsGroup_Project (
InnerProjectID ASC
)
go

/*==============================================================*/
/* Table: DisciplineClass                                       */
/*==============================================================*/
create table DisciplineClass (
   DisciplineClassID    nvarchar(8)          not null,
   DisciplineClassName  nvarchar(20)         null,
   constraint PK_DISCIPLINECLASS primary key (DisciplineClassID)
)
go

/*==============================================================*/
/* Table: Document                                              */
/*==============================================================*/
create table Document (
   DocumentCode         int                  identity,
   DocumentName         nvarchar(40)         null,
   InnerProjectID       nvarchar(40)         not null,
   DocumentClassCode    int                  not null,
   Path                 nvarchar(100)        null,
   constraint PK_DOCUMENT primary key nonclustered (DocumentCode)
)
go

/*==============================================================*/
/* Index: DocumentClass_Document_FK                             */
/*==============================================================*/
create index DocumentClass_Document_FK on Document (
DocumentClassCode ASC
)
go

/*==============================================================*/
/* Index: Project_Document_FK                                   */
/*==============================================================*/
create index Project_Document_FK on Document (
InnerProjectID ASC
)
go

/*==============================================================*/
/* Table: DocumentClass                                         */
/*==============================================================*/
create table DocumentClass (
   DocumentClassCode    int                  identity,
   DocumentClass        nvarchar(50)         null,
   KeyDocument          bit                  null,
   constraint PK_DOCUMENTCLASS primary key nonclustered (DocumentClassCode)
)
go

/*==============================================================*/
/* Table: Expense                                               */
/*==============================================================*/
create table Expense (
   ExpenseID            int                  identity,
   InnerProjectID       nvarchar(40)         null,
   SubmitTime           datetime             null,
   Operator             nvarchar(20)         null,
   ExpenseStatus        nvarchar(10)         null,
   TeacherComment       text                 null,
   AdminComment         text                 null,
   constraint PK_EXPENSE primary key nonclustered (ExpenseID)
)
go

/*==============================================================*/
/* Index: Project_Expense_FK                                    */
/*==============================================================*/
create index Project_Expense_FK on Expense (
InnerProjectID ASC
)
go

/*==============================================================*/
/* Table: ExpenseAttachment                                     */
/*==============================================================*/
create table ExpenseAttachment (
   ExpenseAttachmentID  int                  identity,
   ExpenseID            int                  null,
   Path                 nvarchar(100)        null,
   AttachmentName       nvarchar(60)         null,
   constraint PK_EXPENSEATTACHMENT primary key nonclustered (ExpenseAttachmentID)
)
go

/*==============================================================*/
/* Index: Expense_ExpenseAttachment_FK                          */
/*==============================================================*/
create index Expense_ExpenseAttachment_FK on ExpenseAttachment (
ExpenseID ASC
)
go

/*==============================================================*/
/* Table: ExpenseDetail                                         */
/*==============================================================*/
create table ExpenseDetail (
   ExpenseDetailID      int                  identity,
   ExpenseID            int                  null,
   ExpenseType          nvarchar(40)         null,
   Amount               money                null,
   constraint PK_EXPENSEDETAIL primary key nonclustered (ExpenseDetailID)
)
go

/*==============================================================*/
/* Index: Expense_ExpenseDetail_FK                              */
/*==============================================================*/
create index Expense_ExpenseDetail_FK on ExpenseDetail (
ExpenseID ASC
)
go

/*==============================================================*/
/* Table: ExpenseType                                           */
/*==============================================================*/
create table ExpenseType (
   ExpenseTypeID        int                  not null,
   ExpenseTypeName      nvarchar(40)         null,
   constraint PK_EXPENSETYPE primary key nonclustered (ExpenseTypeID)
)
go

/*==============================================================*/
/* Table: ExpertEvaluationResults                               */
/*==============================================================*/
create table ExpertEvaluationResults (
   ExpertCommentCode    nvarchar(40)         not null,
   UserCode             nvarchar(40)         not null,
   InnerProjectID       nvarchar(40)         not null,
   CommentsGroupCode    nvarchar(40)         not null,
   Comments             text                 null,
   Grade                nvarchar(10)         null,
   Master               bit                  null,
   ExpertState          nvarchar(10)         null,
   ExpertDate           datetime             null,
   constraint PK_EXPERTEVALUATIONRESULTS primary key (ExpertCommentCode),
   constraint AK_PK_EXPERTEVALUATIO_EXPERTEV unique (UserCode, InnerProjectID, CommentsGroupCode)
)
go

/*==============================================================*/
/* Index: CommentsGroup_ExpertEvaluationResults_FK              */
/*==============================================================*/
create index CommentsGroup_ExpertEvaluationResults_FK on ExpertEvaluationResults (
CommentsGroupCode ASC
)
go

/*==============================================================*/
/* Index: Project_ExpertEvaluationResults_FK                    */
/*==============================================================*/
create index Project_ExpertEvaluationResults_FK on ExpertEvaluationResults (
InnerProjectID ASC
)
go

/*==============================================================*/
/* Index: Teacher_ExpertEvaluationResults_FK                    */
/*==============================================================*/
create index Teacher_ExpertEvaluationResults_FK on ExpertEvaluationResults (
UserCode ASC
)
go

/*==============================================================*/
/* Table: FirstClassDiscipline                                  */
/*==============================================================*/
create table FirstClassDiscipline (
   [FirstClassDisciplineName] nvarchar(50)         null,
   FirstClassDisciplineID nvarchar(50)         not null,
   DisciplineClassID    nvarchar(8)          null,
   constraint PK_FIRSTCLASSDISCIPLINE primary key nonclustered (FirstClassDisciplineID)
)
go

/*==============================================================*/
/* Table: GuideTeacher                                          */
/*==============================================================*/
create table GuideTeacher (
   InnerProjectID       nvarchar(40)         not null,
   UserCode             nvarchar(40)         not null,
   Rank                 int                  null,
   constraint AK_PK_GUIDETEACHER_GUIDETEA unique (InnerProjectID, UserCode)
)
go

/*==============================================================*/
/* Index: Project_GuideTeacher_FK                               */
/*==============================================================*/
create index Project_GuideTeacher_FK on GuideTeacher (
InnerProjectID ASC
)
go

/*==============================================================*/
/* Index: Teacher_GuideTeacher_FK                               */
/*==============================================================*/
create index Teacher_GuideTeacher_FK on GuideTeacher (
UserCode ASC
)
go

/*==============================================================*/
/* Table: Project                                               */
/*==============================================================*/
create table Project (
   ProjectSynopsis      text                 null,
   Post_StateID         int                  null,
   InnerProjectID       nvarchar(40)         not null,
   ProjectCode          nvarchar(40)         null,
   ProjectName          nvarchar(100)        null,
   StateID              int                  null,
   MiddleTeacherComments text                 null,
   ApplicationTeacherComments text                 null,
   ConcludingTeacherComments text                 null,
   ApplicationInstituteComments text                 null,
   MiddleInstituteComments text                 null,
   ConcludingInstituteComments text                 null,
   ApplicationSchoolComments text                 null,
   MiddleSchoolComments text                 null,
   ConcludingSchoolComments text                 null,
   TotalFunds           money                null,
   ProjectCategory      text                 null,
   ProjectApplicationStartTime datetime             null,
   ProjectApplicationEndTime datetime             null,
   ResultForm           text                 null,
   ProjectRankID        int                  null,
   ResearchContent      text                 null,
   InnovativeFeatures   text                 null,
   KnowledgeAccumulation text                 null,
   PlanSchedule         text                 null,
   SupportCondition     text                 null,
   ExpectResultForm     text                 null,
   BudgetaryEstimate    text                 null,
   ExamineState         nvarchar(10)         null,
   FirstClassDiscipline nvarchar(50)         null,
   TechnicalRouteFeasibility text                 null,
   ProjectedStatus      nvarchar(10)         null,
   TollGride            int                  null,
   Project              nvarchar(40)         null,
   "TheMid-termResults" nvarchar(10)         null,
   ProjectResults       nvarchar(10)         null,
   ProjectConcludingRemarks text                 null,
   ProjectYear          datetime             null,
   ProjectEndYear       datetime             null,
   constraint PK_PROJECT primary key nonclustered (InnerProjectID)
)
go

/*==============================================================*/
/* Index: State_Project_FK                                      */
/*==============================================================*/
create index State_Project_FK on Project (
StateID ASC
)
go

/*==============================================================*/
/* Index: ProjectRank_Project_FK                                */
/*==============================================================*/
create index ProjectRank_Project_FK on Project (
ProjectRankID ASC
)
go

/*==============================================================*/
/* Table: ProjectRank                                           */
/*==============================================================*/
create table ProjectRank (
   ProjectRankID        int                  identity,
   ProjectRankName      nvarchar(40)         null,
   constraint PK_PROJECTRANK primary key nonclustered (ProjectRankID)
)
go

/*==============================================================*/
/* Table: ProjectRank_Action                                    */
/*==============================================================*/
create table ProjectRank_Action (
   ID                   int                  identity,
   ProjectRankID        int                  not null,
   ActionID             int                  not null,
   StateID              int                  null,
   Post_StateID         int                  null,
   constraint PK_PROJECTRANK_ACTION primary key nonclustered (ID)
)
go

/*==============================================================*/
/* Index: State_PostState_FK                                    */
/*==============================================================*/
create index State_PostState_FK on ProjectRank_Action (
Post_StateID ASC
)
go

/*==============================================================*/
/* Index: TriggerAction_ProjectRank_TriggerAction_FK            */
/*==============================================================*/
create index TriggerAction_ProjectRank_TriggerAction_FK on ProjectRank_Action (
ActionID ASC
)
go

/*==============================================================*/
/* Index: State_PreState_FK                                     */
/*==============================================================*/
create index State_PreState_FK on ProjectRank_Action (
StateID ASC
)
go

/*==============================================================*/
/* Index: ProjectRank_TriggerAction_ProjectRank_FK              */
/*==============================================================*/
create index ProjectRank_TriggerAction_ProjectRank_FK on ProjectRank_Action (
ProjectRankID ASC
)
go

/*==============================================================*/
/* Table: Roles                                                 */
/*==============================================================*/
create table Roles (
   RoleId               nvarchar(40)         not null,
   RoleName             nvarchar(30)         null,
   constraint PK_ROLES primary key nonclustered (RoleId)
)
go

/*==============================================================*/
/* Table: Scheduling                                            */
/*==============================================================*/
create table Scheduling (
   SchedulingCode       nvarchar(40)         not null,
   Year                 int                  null,
   ProgressDescription  text                 null,
   ProgressClass        nvarchar(30)         null,
   BeginDate            datetime             null,
   EndDate              datetime             null,
   IsTimeOut            bit                  null,
   Term                 nvarchar(10)         null,
   constraint PK_SCHEDULING primary key nonclustered (SchedulingCode)
)
go

/*==============================================================*/
/* Table: State                                                 */
/*==============================================================*/
create table State (
   StateID              int                  identity,
   StateName            nvarchar(30)         null,
   constraint PK_STATE primary key nonclustered (StateID)
)
go

/*==============================================================*/
/* Table: Student                                               */
/*==============================================================*/
create table Student (
   UserCode             nvarchar(40)         not null,
   Name                 nvarchar(20)         null,
   Grade                int                  null,
   Institute            nvarchar(20)         null,
   Profession           nvarchar(30)         null,
   Class                nvarchar(20)         null,
   GraduationYear       int                  null,
   FirstClassDiscipline nchar(50)            null,
   constraint PK_STUDENT primary key nonclustered (UserCode)
)
go

/*==============================================================*/
/* Table: Teacher                                               */
/*==============================================================*/
create table Teacher (
   UserCode             nvarchar(40)         not null,
   Name                 nvarchar(20)         null,
   ResearchingProjectNum int                  null,
   Institute            nvarchar(20)         null,
   Profession           nvarchar(30)         null,
   FirstClassDiscipline nvarchar(50)         null,
   Signature            text                 null,
   constraint PK_TEACHER primary key nonclustered (UserCode)
)
go

/*==============================================================*/
/* Table: TeamMember                                            */
/*==============================================================*/
create table TeamMember (
   InnerProjectID       nvarchar(40)         not null,
   UserCode             nvarchar(40)         not null,
   AchieveWork          text                 null,
   MainReseachWork      text                 null,
   Rank                 int                  null,
   constraint AK_PK_TEAMMEMBER_TEAMMEMB unique (InnerProjectID, UserCode)
)
go

/*==============================================================*/
/* Index: Project_TeamMember_FK                                 */
/*==============================================================*/
create index Project_TeamMember_FK on TeamMember (
InnerProjectID ASC
)
go

/*==============================================================*/
/* Index: Student_TeamMember_FK                                 */
/*==============================================================*/
create index Student_TeamMember_FK on TeamMember (
UserCode ASC
)
go

/*==============================================================*/
/* Table: "User"                                                */
/*==============================================================*/
create table "User" (
   Account              nvarchar(40)         null,
   UserCode             nvarchar(40)         not null,
   BranchID             int                  null,
   Name                 nvarchar(20)         null,
   Email                nvarchar(40)         null,
   IDCard               nvarchar(20)         null,
   Mobile               nvarchar(15)         null,
   Tel                  nvarchar(60)         null,
   Password             nvarchar(30)         null,
   PasswordSalt         nvarchar(30)         null,
   PasswordFormat       nvarchar(20)         null,
   IsLockOut            bit                  null default 0,
   IsAvailable          bit                  null default 0,
   IsDelete             bit                  null default 0,
   LastLogonTime        datetime             null,
   UserCreateTime       datetime             null,
   Sex                  nvarchar(2)          null,
   constraint PK_USER primary key nonclustered (UserCode)
)
go

/*==============================================================*/
/* Index: Department_UserCode_FK                                */
/*==============================================================*/
create index Department_UserCode_FK on "User" (
BranchID ASC
)
go

/*==============================================================*/
/* Table: UsersInRoles                                          */
/*==============================================================*/
create table UsersInRoles (
   Id                   int                  identity,
   RoleId               nvarchar(40)         not null,
   UserCode             nvarchar(40)         null,
   constraint PK_USERSINROLES primary key nonclustered (Id)
)
go

/*==============================================================*/
/* Index: User_Role_FK                                          */
/*==============================================================*/
create index User_Role_FK on UsersInRoles (
UserCode ASC
)
go

/*==============================================================*/
/* Index: Roles_Users_FK                                        */
/*==============================================================*/
create index Roles_Users_FK on UsersInRoles (
RoleId ASC
)
go

alter table Achievement
   add constraint FK_ACHIEVEM_PROJECT_A_PROJECT foreign key (InnerProjectID)
      references Project (InnerProjectID)
go

alter table Branch
   add constraint FK_BRANCH_PARENTDEP_BRANCH foreign key (ParentBranchID)
      references Branch (BranchID)
go

alter table CommentGroup
   add constraint FK_COMMENTG_DEPARTMEN_BRANCH foreign key (BranchID)
      references Branch (BranchID)
go

alter table CommentGroup
   add constraint FK_COMMENTG_SCHEDULIN_SCHEDULI foreign key (SchedulingCode)
      references Scheduling (SchedulingCode)
go

alter table CommentGroup_Teacher
   add constraint FK_COMMENTG_COMMENTGR_COMMENTG foreign key (CommentsGroupCode)
      references CommentGroup (CommentsGroupCode)
go

alter table CommentGroup_Teacher
   add constraint FK_COMMENTG_COMMENTGR_TEACHER foreign key (UserCode)
      references Teacher (UserCode)
go

alter table CommentsGroup_Project
   add constraint FK_COMMENTS_COMMENTSG_COMMENTG foreign key (CommentsGroupCode)
      references CommentGroup (CommentsGroupCode)
go

alter table CommentsGroup_Project
   add constraint FK_COMMENTS_PROJECT_C_PROJECT foreign key (InnerProjectID)
      references Project (InnerProjectID)
go

alter table Document
   add constraint FK_DOCUMENT_DOCUMENTC_DOCUMENT foreign key (DocumentClassCode)
      references DocumentClass (DocumentClassCode)
go

alter table Document
   add constraint FK_DOCUMENT_PROJECT_D_PROJECT foreign key (InnerProjectID)
      references Project (InnerProjectID)
go

alter table Expense
   add constraint FK_EXPENSE_PROJECT_E_PROJECT foreign key (InnerProjectID)
      references Project (InnerProjectID)
go

alter table ExpenseAttachment
   add constraint FK_EXPENSEA_EXPENSE_E_EXPENSE foreign key (ExpenseID)
      references Expense (ExpenseID)
go

alter table ExpenseDetail
   add constraint FK_EXPENSED_EXPENSE_E_EXPENSE foreign key (ExpenseID)
      references Expense (ExpenseID)
go

alter table ExpertEvaluationResults
   add constraint FK_EXPERTEV_COMMENTSG_COMMENTG foreign key (CommentsGroupCode)
      references CommentGroup (CommentsGroupCode)
go

alter table ExpertEvaluationResults
   add constraint FK_EXPERTEV_PROJECT_E_PROJECT foreign key (InnerProjectID)
      references Project (InnerProjectID)
go

alter table ExpertEvaluationResults
   add constraint FK_EXPERTEV_TEACHER_E_TEACHER foreign key (UserCode)
      references Teacher (UserCode)
go

alter table FirstClassDiscipline
   add constraint FK_FIRSTCLA_FIRSTCLAS_DISCIPLI foreign key (DisciplineClassID)
      references DisciplineClass (DisciplineClassID)
go

alter table GuideTeacher
   add constraint FK_GUIDETEA_PROJECT_G_PROJECT foreign key (InnerProjectID)
      references Project (InnerProjectID)
go

alter table GuideTeacher
   add constraint FK_GUIDETEA_TEACHER_G_TEACHER foreign key (UserCode)
      references Teacher (UserCode)
go

alter table Project
   add constraint FK_PROJECT_PROJECTRA_PROJECTR foreign key (ProjectRankID)
      references ProjectRank (ProjectRankID)
go

alter table Project
   add constraint FK_PROJECT_STATE_PRO_STATE foreign key (StateID)
      references State (StateID)
go

alter table ProjectRank_Action
   add constraint FK_PROJECTR_PROJECTRA_PROJECTR foreign key (ProjectRankID)
      references ProjectRank (ProjectRankID)
go

alter table ProjectRank_Action
   add constraint FK_PROJECTR_STATE_POS_STATE foreign key (Post_StateID)
      references State (StateID)
go

alter table ProjectRank_Action
   add constraint FK_PROJECTR_STATE_PRE_STATE foreign key (StateID)
      references State (StateID)
go

alter table ProjectRank_Action
   add constraint FK_PROJECTR_TRIGGERAC_ACTION foreign key (ActionID)
      references Action (ActionID)
go

alter table Student
   add constraint FK_STUDENT_USER_STUD_USER foreign key (UserCode)
      references "User" (UserCode)
go

alter table Teacher
   add constraint FK_TEACHER_USER_STUD_USER foreign key (UserCode)
      references "User" (UserCode)
go

alter table TeamMember
   add constraint FK_TEAMMEMB_PROJECT_T_PROJECT foreign key (InnerProjectID)
      references Project (InnerProjectID)
go

alter table TeamMember
   add constraint FK_TEAMMEMB_STUDENT_T_STUDENT foreign key (UserCode)
      references Student (UserCode)
go

alter table "User"
   add constraint FK_USER_DEPARTMEN_BRANCH foreign key (BranchID)
      references Branch (BranchID)
go

alter table UsersInRoles
   add constraint FK_USERSINR_ROLES_USE_ROLES foreign key (RoleId)
      references Roles (RoleId)
go

alter table UsersInRoles
   add constraint FK_USERSINR_USER_ROLE_USER foreign key (UserCode)
      references "User" (UserCode)
go

