//--------------------------------------------
// Configuration Keys
//--------------------------------------------
#define kPLConfigurationKeyUsername @"com.monsterbooks.user.username"
#define kPLConfigurationKeyPassword @"com.monsterbooks.user.password"
#define PLConfigurationFFFontSize @"com.monsterbooks.fanfiction.font.size"
#define PLConfigurationFFFontSizeDefault 100
#define PLConfigurationFFFontAlignment @"com.monsterbooks.fanfiction.font.alignment"
#define PLConfigurationFFFontAlignmentDefault PLFFTextAlignLeft
#define PLConfigurationFFTextContrast @"com.monsterbooks.fanfiction.font.contrast"
#define PLConfigurationFFTextContrastDefault PLFFTextContrastBlackOnWhite
#define PLConfigurationReaderAutorotate @"com.monsterbooks.reader.autorotate"
#define PLConfigurationReaderAutorotateDefault YES



//--------------------------------------------
// User data Keys
//--------------------------------------------
#define PLUserDataReadingList @"com.monsterbooks.user.reading.list"
#define PLUserDataFavoritesStories @"com.monsterbooks.user.favorites.stories"
#define PLUserDataFavoritesCommunities @"com.monsterbooks.user.favorites.communities"
#define PLUserDataBrowseCategorySortType @"com.monsterbooks.user.browse.category.sort.type"
#define PLUserDataBrowseCrossoverSortType @"com.monsterbooks.user.browse.crossover.sort.type"
#define PLUserDataBrowseCategoryListType @"com.monsterbooks.user.browse.category.list.type"
#define PLUserDataBrowseCategoryCategory @"com.monsterbooks.user.browse.category.category"
#define PLUserDataCommunitiesCategorySortType @"com.monsterbooks.user.communities.crossover.sort.type"
#define PLUserDataSearchStorySortType @"com.monsterbooks.user.search.story.sort.type"
#define PLUserDataSearchCommunitySortType @"com.monsterbooks.user.search.community.sort.type"



//--------------------------------------------
// Application constants
//--------------------------------------------
// crash reporter
#define PLCrashReporterUrl @"http://crashreporter.pentaloop.com/crash_v200.php"

#define PLAppSiteUrl @"http://monsterbooks.pentaloop.com/"
#define PLFacebookUrl @"http://www.facebook.com"
#define PLTwitterUrl @"http://www.twitter.com"
#define PLAppStoreReviewUrl @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=426910690&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
#ifndef DEBUG
#define PLServerUrl @"http://monsterbooks.pentaloop.com"
#else
#define PLServerUrl @"http://192.168.1.234/monsterbooks"
#endif
#define PLSuggestionEmailAddress @"monsterbooks@pentaloop.com"
#define PLBugsEmailAddress @"monsterbooks@pentaloop.com"
#define USER_AGENT @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0) Gecko/20100101 Firefox/4.0"


//--------------------------------------------
// Fanfic constants
//--------------------------------------------
#define PLConfigurationStoryCategoriesList @"com.monsterbooks.user.fanfiction.storyCategories"
#define PLConfigurationStoryCategoriesListUpdateDate @"com.monsterbooks.user.fanfiction.storyCategories.updateDate"
#define PLConfigurationCommunityCategoriesList @"com.monsterbooks.user.fanfiction.communityCategories"
#define PLConfigurationCommunityCategoriesListUpdateDate @"com.monsterbooks.user.fanfiction.communityCategories.updateDate"
#define PLConfigurationSearchLastSearchStoryCategory @"com.monsterbooks.user.fanfiction.lastSearchStoryCategory"
#define PLConfigurationSearchLastSearchStorySubCategory @"com.monsterbooks.user.fanfiction.lastSearchStorySubCategory"
#define PLConfigurationSearchLastSearchCommunityCategory @"com.monsterbooks.user.fanfiction.lastSearchCommunityCategory"
#define PLConfigurationSearchLastSearchCommunitySubCategory @"com.monsterbooks.user.fanfiction.lastSearchCommunitySubCategory"