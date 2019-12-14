import axios from 'axios';

  const token = document.querySelector("meta[name=csrf-token]") || {content:'no-csrf-token'};
  // console.log(token.content);
  const ax = axios.create({
    headers: {
      common: {
        'X-CSRF-TOKEN': token.content
      },
    },
  });

  export default ax;
  
  // 用的時候, bx 模組自行決定名稱
  import bx from 'helpers/ax';
