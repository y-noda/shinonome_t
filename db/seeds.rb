load 'db/seeds_category_type.rb'
load 'db/seeds_category.rb'
load 'db/seeds_video.rb'
load 'db/seeds_admin.rb'
load 'db/seeds_general.rb'
load 'db/seeds_production_user.rb'
load 'db/seeds_production_test_user.rb'
load 'db/seeds_checksheet_guidance.rb'
load 'db/seeds_checksheet_ict.rb'
load 'db/seeds_checksheet_health.rb'
load 'db/seeds_questionnaires.rb'
load 'db/seeds_questionnaire_answers.rb'
load 'db/seeds_checksheet_answer_general.rb'
load 'db/seeds_progress.rb'

Seed::SeedCategoryType.seed
Seed::SeedCategory.seed
Seed::SeedVideo.seed
Seed::SeedAdmin.seed
Seed::SeedGeneral.seed
Seed::SeedProductionUser.seed
Seed::SeedProductionTestUser.seed
Seed::SeedChecksheetGuidance.seed
Seed::SeedChecksheetICT.seed
Seed::SeedChecksheetHeals.seed
Seed::SeedQuestionnaires.seed
Seed::SeedQuestionnaireAnswers.seed
Seed::SeedChecksheetAnswerGeneral.seed
Seed::SeedProgress.seed
