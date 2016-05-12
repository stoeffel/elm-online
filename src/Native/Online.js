var _stoeffel$elm_online$Native_Online = function() {
  function listen(toSuccessTask) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(){
      function updateOnlineStatus() {
        onChange(!!navigator.onLine);
      }
      function onChange(isOnline) {
        var task = toSuccessTask(isOnline);
        _elm_lang$core$Native_Scheduler.rawSpawn(task);
      }

      window.addEventListener('online',  updateOnlineStatus);
      window.addEventListener('offline', updateOnlineStatus);

      updateOnlineStatus()

      return function() {
      };
    });
  }
  return {
    listen: F2(listen)
  };

}();
