import Vue from 'vue'
import Vuex from 'vuex'
import auth from '@/store/modules/auth'

Vue.use(Vuex)

/*
Vuexはデータとその状態に関するすべてを一元管理する「状態管理」のためのライブラリ
コンポーネント間のemit、propsのバケツリレー問題を解決する。
state: 変数がある場所。直接値を変更することをせず、mutation経由で値を更新する。
getters: stateの値を加工して取得したい場合に利用する。
mutations: 同期的にstateの値を更新する。
actions: 非同期処理とmutations操作をする場合。APIを利用する場合など
*/
const store = new Vuex.Store({
  // 可読性、保守性のためにmodule化する
  modules: {
    auth
  }
})

export default store;
