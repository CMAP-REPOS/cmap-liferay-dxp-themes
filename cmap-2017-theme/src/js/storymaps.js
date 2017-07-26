(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define('storymaps', [], factory);
    } else if (typeof module === 'object' && module.exports) {
        module.exports = factory();
    } else {
        root.storymaps = factory();
  }
}(this, function () {

    return {
    }
    
}));
