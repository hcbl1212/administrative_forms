const React = require('react');
const { connect } = require('react-redux');
const { Modal } = require('../modal.jsx');
const {
  changeDateReceived,
  changeDateCanceled,
} = require('../actionCreators.js');

let ChangeDateConfirm = ({
	specimen,
	open,
	onOk,
	onCancel,
}) => (
  !open ? null : (
    <Modal>
      <h4>Existing Requisition Number found!</h4>
      <p>Do you want to navigate to {specimen.date_received}?</p>
      <a className="ok btn btn-primary" onClick={() => onOk(specimen.date_received)}>Yes</a>
      <a className="cancel btn btn-secondary" onClick={onCancel}>No</a>
    </Modal>
  )
);

ChangeDateConfirm.propTypes = {
  specimen: React.PropTypes.object,
  open: React.PropTypes.bool,
  onOk: React.PropTypes.func,
  onCancel: React.PropTypes.func,
};

const mapStateToProps = ({ changeDateConfirm }) => (changeDateConfirm);
const mapDispatchToProps = dispatch => ({
  onOk: date => dispatch(changeDateReceived(date)),
  onCancel: () => dispatch(changeDateCanceled()),
});

ChangeDateConfirm = connect(
  mapStateToProps, 
  mapDispatchToProps
)(ChangeDateConfirm);

export { ChangeDateConfirm };
