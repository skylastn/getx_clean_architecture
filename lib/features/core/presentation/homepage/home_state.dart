import '../../../../shared/core/domain/model/content_model.dart';
import '../../domain/model/response/komik_response.dart';

class HomeState {
  List<DataKomik> listPopularKomik = [];

  List<String> imageList = [
    'https://static.vecteezy.com/system/resources/previews/007/301/684/original/pet-shop-banner-design-template-cartoon-illustration-of-cats-dogs-house-food-vector.jpg',
    'https://i1.wp.com/pet-care.co.za/wp-content/uploads/2018/07/Pet-Care-Banner.jpg?ssl=1'
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];
  bool isShowProduct = false;
  ContentModel? selectedCategory;
  List<ContentModel> listCategory = [
    ContentModel(
      index: 0,
      content: 'assets/icons/ic_grooming.png',
      type: ServiceType.grooming,
      name: 'Action',
    ),
    ContentModel(
      index: 1,
      content: 'assets/icons/ic_daycare.png',
      type: ServiceType.daycare,
      name: 'Comedy',
    ),
    ContentModel(
      index: 2,
      content: 'assets/icons/ic_walking.png',
      type: ServiceType.walking,
      name: 'Harem',
    ),
    ContentModel(
      index: 3,
      content: 'assets/icons/ic_walking.png',
      type: ServiceType.more,
      name: 'More',
    ),
  ];

  List<ContentModel> listContent = [
    ContentModel(
      index: 0,
      content:
          'https://komikcast.lol/wp-content/uploads/2023/02/nano.jpg?w=400&q=70',
      type: null,
      name: 'Nano Machine',
    ),
    ContentModel(
      index: 1,
      content:
          'https://komikcast.lol/wp-content/uploads/2024/06/tpog62452432-e1717599878488.jpg?w=400&q=70',
      type: null,
      name: 'The Possessed Genius Gaming Stream',
    ),
    ContentModel(
      index: 2,
      content:
          'https://komikcast.lol/wp-content/uploads/2023/11/genius.jpg?w=400&q=70',
      type: null,
      name: 'The Genius Assassin Who Takes',
    ),
    ContentModel(
      index: 3,
      content:
          'https://komikcast.lol/wp-content/uploads/2023/10/001-e1697473180192.jpg?w=400&q=70',
      type: null,
      name: 'Apotheosis',
    ),
  ];

  List<ContentModel> listTab = [
    ContentModel(
      index: 0,
      content: '',
      name: 'Home',
      type: TabType.home,
    ),
    ContentModel(
      index: 1,
      content: '',
      name: 'Search',
      type: TabType.search,
    ),
    ContentModel(
      index: 2,
      content: '',
      name: 'Genre',
      type: TabType.genre,
    ),
    ContentModel(
      index: 3,
      content: '',
      name: 'Libray',
      type: TabType.library,
    ),
    ContentModel(
      index: 4,
      content: '',
      name: 'Me',
      type: TabType.me,
    ),
  ];
}

enum ServiceType {
  grooming,
  daycare,
  walking,
  training,
  petTaxi,
  sitting,
  boarding,
  more,
}

enum TabType {
  search,
  home,
  genre,
  library,
  me,
}
