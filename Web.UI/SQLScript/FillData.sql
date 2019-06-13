﻿
SET IDENTITY_INSERT [dbo].[ProjectRank] ON 

INSERT [dbo].[ProjectRank] ([ProjectRankID], [ProjectRankName]) VALUES (0, N'全部')
INSERT [dbo].[ProjectRank] ([ProjectRankID], [ProjectRankName]) VALUES (1, N'国家级')
INSERT [dbo].[ProjectRank] ([ProjectRankID], [ProjectRankName]) VALUES (2, N'省级')
INSERT [dbo].[ProjectRank] ([ProjectRankID], [ProjectRankName]) VALUES (3, N'校级')
SET IDENTITY_INSERT [dbo].[ProjectRank] OFF
SET IDENTITY_INSERT [dbo].[State] ON 

INSERT [dbo].[State] ([StateID], [StateName]) VALUES (0, N'开始')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (1, N'申请书草稿')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (2, N'申请书指导教师待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (3, N'申请书学院待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (4, N'申请书学校待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (5, N'申请书退修')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (6, N'立项')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (7, N'中期草稿')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (8, N'中期指导教师待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (9, N'中期学院待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (10, N'中期退修')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (11, N'中期学校待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (12, N'中期完成')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (13, N'结题答辩草稿')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (14, N'结题答辩指导教师待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (15, N'结题答辩材料学院待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (16, N'结题答辩退修')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (17, N'学院结题材料指导教师待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (18, N'学院结题材料草稿')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (19, N'结题项目学院退修')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (20, N'结题材料指导教师待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (21, N'结题材料草稿')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (22, N'结题项目退修')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (23, N'答辩学院待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (24, N'结题项目学校待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (25, N'答辩学校待审')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (26, N'结题')
INSERT [dbo].[State] ([StateID], [StateName]) VALUES (27, N'项目终止')
SET IDENTITY_INSERT [dbo].[State] OFF
SET IDENTITY_INSERT [dbo].[Action] ON 

INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (1, N'1', N'学生填写申报书')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (2, N'2', N'学生提交申报书')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (3, N'3', N'指导教师申报书审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (4, N'4', N'指导教师申报书审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (5, N'5', N'学生修改申请书')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (6, N'6', N'学院申请书审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (7, N'7', N'学院申请书审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (8, N'8', N'学院申请书退修')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (9, N'9', N'学校申请书审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (10, N'10', N'学校申请书审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (11, N'11', N'学生填写中期报告')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (12, N'12', N'学生提交中期报告')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (13, N'13', N'中期指导教师审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (14, N'14', N'中期指导教师审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (15, N'15', N'学生修改中期报告')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (16, N'16', N'中期学院审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (17, N'17', N'中期学院审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (18, N'18', N'中期学校审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (19, N'19', N'中期学校审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (20, N'20', N'学生填写结题报告')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (21, N'21', N'学生提交结题报告')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (22, N'22', N'结题答辩指导教师审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (23, N'23', N'结题答辩指导教师审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (24, N'24', N'学生结题申请书修改')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (25, N'25', N'结题答辩材料学院审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (26, N'26', N'结题答辩材料学院审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (27, N'27', N'结题答辩学校通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (28, N'28', N'结题答辩学校未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (29, N'29', N'结题答辩学院通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (30, N'30', N'结题答辩学院未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (31, N'31', N'结题答辩学院审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (32, N'32', N'学生修改结题材料')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (33, N'33', N'学生提交结题材料')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (34, N'34', N'结题材料指导教师审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (35, N'35', N'结题材料指导教师审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (36, N'36', N'结题项目学校审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (37, N'37', N'结题项目学校审核未通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (38, N'38', N'结题材料学生修改')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (39, N'39', N'结题材料学生提交')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (40, N'40', N'结题材料指导教师审核通过')
INSERT [dbo].[Action] ([ActionID], [ActionName], [ActionView]) VALUES (41, N'41', N'结题材料指导教师审核未通过')
SET IDENTITY_INSERT [dbo].[Action] OFF
SET IDENTITY_INSERT [dbo].[ProjectRank_Action] ON 

INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (1, 0, 1, 0, 1)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (2, 0, 2, 1, 2)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (3, 0, 3, 2, 3)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (4, 0, 4, 2, 5)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (5, 0, 5, 5, 1)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (6, 0, 6, 3, 4)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (7, 0, 7, 3, 27)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (8, 0, 8, 3, 5)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (9, 0, 9, 4, 6)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (10, 0, 10, 4, 27)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (11, 0, 11, 6, 7)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (12, 0, 12, 7, 8)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (13, 0, 13, 8, 9)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (14, 0, 14, 8, 10)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (15, 0, 15, 10, 7)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (16, 0, 16, 9, 11)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (17, 0, 17, 9, 10)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (18, 0, 18, 11, 12)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (19, 0, 19, 11, 10)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (20, 0, 20, 12, 13)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (21, 0, 21, 13, 14)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (22, 0, 22, 14, 15)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (23, 0, 23, 14, 16)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (24, 0, 24, 16, 13)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (25, 1, 25, 15, 25)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (26, 2, 25, 15, 25)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (27, 3, 25, 15, 23)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (28, 0, 26, 15, 16)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (29, 1, 27, 25, 24)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (30, 2, 28, 25, 12)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (31, 3, 29, 23, 24)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (32, 3, 30, 23, 12)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (33, 3, 31, 23, 19)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (34, 3, 32, 19, 18)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (35, 3, 33, 18, 17)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (36, 3, 34, 17, 23)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (37, 3, 35, 17, 19)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (38, 0, 36, 24, 26)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (39, 0, 37, 24, 22)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (40, 0, 38, 22, 21)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (41, 0, 39, 21, 20)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (42, 0, 40, 20, 23)
INSERT [dbo].[ProjectRank_Action] ([ID], [ProjectRankID], [ActionID], [StateID], [Post_StateID]) VALUES (43, 0, 41, 20, 22)
SET IDENTITY_INSERT [dbo].[ProjectRank_Action] OFF