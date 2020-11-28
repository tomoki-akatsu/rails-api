import axios from 'axios'

// 変数を保存する場所
// 直接変更は行わない、mutations経由で値を更新する
const state = {
  currentUser: null
};

// stateの値を利用して計算する場合は、gettersを利用する
// キャッシュ機構が備わっている。
const getters = {
  currentUser: state => state.currentUser
};

// 非同期にstateを書き換える場合はactions -> mutationsを経由する
const actions = {
  async login({ commit }, sessionParams) {
    const res = await axios.post(`/api/session`, sessionParams)
    commit("SET_CURRENT_USER", res.data.user)
  }
};

// stateの値を書き換える場合は、必ずmutations経由で値を更新する。
// 同期的にstateを書き換える場合はmutationsを使用する
const mutations = {
  SET_CURRENT_USER: (state, user) => {
    state.currentUser = user;
    // ローカルストレージにユーザー情報を格納
    localStorage.setItem('currentUser', JSON.stringify(user))
    // axiosを利用して通信をするときに、トークンをヘッダーに付与する設定
    axios.defaults.headers.common['Authorization'] = `Bearer ${user.token}`
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
};
