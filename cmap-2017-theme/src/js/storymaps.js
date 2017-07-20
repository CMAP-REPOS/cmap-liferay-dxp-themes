(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as a "named" module.
        define('storymaps', [], factory);
    } else if (typeof module === 'object' && module.exports) {
        // Node. Does not work with strict CommonJS, but
        // only CommonJS-like environments that support module.exports,
        // like Node.
        module.exports = factory();
    } else {
        // Browser globals (root is window)
        root.storymaps = factory();
  }
}(this, function () {

    return {
        storySteps: [],
        storyOverlays: []
    }

}));
