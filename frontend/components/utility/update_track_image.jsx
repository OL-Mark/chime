var React = require("react");
var Thumbnail = require("react-bootstrap").Thumbnail;

module.exports = React.createClass({
  _handleFile: function () {
    var reader = new FileReader();
    var img = this.refs.file.files[0];

    if (img === null) { return; }

    reader.onloadend = function () {
      this.props.setState({ imgUrl: reader.result });
    }.bind(this);

    reader.readAsDataURL(img);
    this.props.setState({ disabled: false, img: img });
  },

  render: function () {
    return (
      <div className="upload-img">
        <span className="btn btn-default btn-file">
          <i className="fa fa-file-image-o"></i> Update image

          <input type="file" accept="image/*"ref="file"
            onChange={ this._handleFile } />
        </span>

        <Thumbnail src={ this.props.imgUrl } />
      </div>
    );
  }
});
