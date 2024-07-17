# JavaScript

## 破解网页不可粘贴内容等限制

```js
var allowPaste = function(e){
  e.stopImmediatePropagation();
  return true;
};
document.addEventListener('paste', allowPaste, true);
```