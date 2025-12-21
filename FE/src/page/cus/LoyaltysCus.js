import React, { useState } from 'react';
import { Layout, Typography, Input, Button, Checkbox, Modal } from 'antd';
import {
	GiftOutlined,
	ArrowLeftOutlined,
	SmileOutlined,
} from '@ant-design/icons';
import { useNavigate } from 'react-router-dom';

const { Header, Content } = Layout;
const { Title, Text } = Typography;

export default function CustomerLoyaltyPage() {
	const [phone, setPhone] = useState('');
	const [agree, setAgree] = useState(false);
	const [error, setError] = useState(''); // ✅ lỗi hiển thị bên dưới
	const [isSuccessModal, setIsSuccessModal] = useState(false); // ✅ popup thành công
	const navigate = useNavigate();

	// ✅ validate nhập số
	const handlePhoneChange = (e) => {
		const value = e.target.value;

		// Nếu nhập ký tự không phải số => reset và báo lỗi
		if (/[^0-9]/.test(value)) {
			setPhone('');
			setError('Vui lòng nhập số điện thoại hợp lệ!');
			return;
		}

		setPhone(value);
		setError(''); // reset lỗi khi nhập đúng
	};

	const handleSubmit = () => {
		if (!phone) {
			setError('Vui lòng nhập số điện thoại!');
			return;
		}
		if (phone.length < 10) {
			setError('Số điện thoại phải có ít nhất 10 chữ số!');
			return;
		}
		if (!agree) {
			setError('Hãy đồng ý với chính sách dịch vụ trước!');
			return;
		}
		if (phone.length !== 10 || !/^0\d{9}$/.test(phone)) {
			setError('Vui lòng nhập số điện thoại hợp lệ (10 số, bắt đầu bằng 0)');
			return;
		}

		// ✅ Nếu pass hết thì hiển thị popup thành công
		setIsSuccessModal(true);
		setError('');
	};

	return (
		<Layout style={{ minHeight: '100vh', background: '#fff' }}>
			{/* -------- HEADER -------- */}
			<Header
				style={{
					background: '#fff',
					padding: '12px',
					textAlign: 'center',
					position: 'relative',
					borderBottom: '1px solid #f0f0f0',
					marginBottom: 24,
				}}
			>
				<ArrowLeftOutlined
					style={{ position: 'absolute', left: 16, top: 18, fontSize: 18 }}
					onClick={() => navigate(-1)}
				/>
				<img
					src='/assets/images/Logo.png'
					alt='logo'
					style={{ height: 50, marginBottom: 0 }}
				/>
				<Title
					level={5}
					style={{
						margin: 0,
						color: '#226533',
						fontWeight: 'bold',
						marginTop: 4,
						fontSize: 24,
					}}
				>
					Nhà hàng Phương Nam
				</Title>
			</Header>

			{/* -------- CONTENT -------- */}
			<Content style={{ padding: '24px', textAlign: 'center' }}>
				<Title
					level={4}
					style={{
						marginBottom: 19,
						color: '#226533',
						fontWeight: 'bold',
						fontSize: 20,
					}}
				>
					Nhập số điện thoại
				</Title>
				<GiftOutlined
					style={{
						fontSize: 40,
						color: '#226533',
						background: '#f6ffed',
						borderRadius: '50%',
						padding: 12,
						marginBottom: 16,
					}}
				/>
				<Text style={{ display: 'block', marginBottom: 24, color: '#666' }}>
					Nhập số điện thoại của bạn để tích điểm và nhận ưu đãi. <br />
					Chúng tôi tôn trọng quyền riêng tư và không chia sẻ thông tin của bạn.
				</Text>

				{/* Input phone */}
				<Input
					placeholder='09xx xxx xxx'
					value={phone}
					onChange={handlePhoneChange}
					style={{
						borderRadius: 8,
						height: 45,
						marginBottom: 8,
						textAlign: 'center',
					}}
					maxLength={10}
				/>

				{/* Checkbox */}
				<Checkbox
					checked={agree}
					onChange={(e) => setAgree(e.target.checked)}
					style={{ marginBottom: 8 }}
				>
					Tôi đồng ý với{' '}
					<a href='/cus/' style={{ color: '#226533' }}>
						điều khoản và chính sách bảo mật
					</a>
				</Checkbox>

				{/* Hiển thị lỗi dưới checkbox */}
				{error && (
					<div style={{ color: 'red', fontSize: 13, marginBottom: 16 }}>
						{error}
					</div>
				)}

				{/* Button submit */}
				<Button
					type='primary'
					block
					size='large'
					shape='round'
					onClick={handleSubmit}
					style={{
						background: '#226533',
						borderColor: '#226533',
						color: '#fff',
						fontWeight: 'bold',
						fontSize: 16,
					}}
				>
					Tích điểm
				</Button>
			</Content>

			{/* -------- MODAL THÀNH CÔNG -------- */}
			<Modal
				title='🎉 Tích điểm thành công!'
				centered
				open={isSuccessModal}
				onCancel={() => setIsSuccessModal(false)}
				footer={[
					<Button
						key='ok'
						type='primary'
						style={{ background: '#226533' }}
						onClick={() => {
							setIsSuccessModal(false);
							navigate('/cus/homes'); // chuyển về Home
						}}
					>
						Xác nhận
					</Button>,
				]}
			>
				<div style={{ textAlign: 'center', padding: 10 }}>
					<SmileOutlined
						style={{ fontSize: 40, color: '#226533', marginBottom: 10 }}
					/>
					<p>Bạn đã được tích điểm thành công 🎉</p>
					<p>
						Cảm ơn bạn đã lựa chọn <b>Phương Nam</b> 💚
					</p>
				</div>
			</Modal>
		</Layout>
	);
}
