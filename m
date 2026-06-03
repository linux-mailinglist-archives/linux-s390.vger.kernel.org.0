Return-Path: <linux-s390+bounces-20467-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1iMsKGK7IGoL7QAAu9opvQ
	(envelope-from <linux-s390+bounces-20467-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 01:40:18 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAC263BE23
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 01:40:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=CXGG6ACJ;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20467-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20467-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78BF13008FE8
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04DC4A2E03;
	Wed,  3 Jun 2026 23:40:12 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592204B8DC0;
	Wed,  3 Jun 2026 23:40:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530012; cv=none; b=AuAhTOG55dfHNXPqjXp+rCDVoe3bJRy3Y/6NYuH9rlVifOjIW19FSkLUd3cUP8eJOEb0xwsuI7HAruQbNykQdoH8tgOLdGTr10G4FuzAo16zCAx6T3PLzNSITZ2X6jI82RJCai3zdyvr/hQJdMfaWrBWK233VdSsxPFdET+NN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530012; c=relaxed/simple;
	bh=2YcRYUbuddfVw28aU3j4QZbrbfnvM2zIzQcaTBVBdU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U58z1cBeX/j7h7PwvFqXFrbp08Zdsr2GK/qguucsMzyCIfwFLn3P3ipyL723/LfCKC6fc5VXIqvvGUFZyaTqjp+N6Ko+cnzCC67+AZd1YqwAyQ9YAh68gue8kHph5my73hWRQu5kQdbD93Q1kJEVDc10BESQnMUAn9BbjWynRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CXGG6ACJ; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653N44TH3166613;
	Wed, 3 Jun 2026 23:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6hqpmz
	phi1YOTFB8dJmA+/7DTOse78mxtXwBZ7LuISQ=; b=CXGG6ACJvIiCpN0onETtQM
	Y/f8YSfCxQYs/Kyl16p25FNvzFBUEWU6QAjC+q5fSYWKs3HXHVeNCJ9lwXWiE6hx
	KlNW31XKu8CWiKbd/8cHhbnXJYTRC4bJ0l0AbPWwOsNchCGSw4+nHRn1qdsbTBb/
	A8mlNxhTSHK33joB39Gaa79P4NlPN1x+MPHu5NGV5aoELqZL/guo88NioMfS9Fyo
	3EQ7e5Qt1M+H16FUp4kGN3C7PN4+ZaEk/KSWamlB3QHxGTKDdhe7gDlAO/iLsBos
	vBprNL8OC+BVd1nhSYKnixNgZjiQQukRnexH/oewe+63yNcJue7xY2s/T9LFVozA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaecuq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 23:40:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653Nd5FZ023631;
	Wed, 3 Jun 2026 23:40:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegtd5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 23:40:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653Ne4iC43647342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 23:40:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5023058059;
	Wed,  3 Jun 2026 23:40:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A08858061;
	Wed,  3 Jun 2026 23:40:03 +0000 (GMT)
Received: from [9.61.253.104] (unknown [9.61.253.104])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 23:40:03 +0000 (GMT)
Message-ID: <94fddb17-f4f1-4769-b73b-fb3523c37af2@linux.ibm.com>
Date: Wed, 3 Jun 2026 16:40:01 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/4] vfio-pci/zdev: Add a device feature for error
 information
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260603182415.2324-1-alifm@linux.ibm.com>
 <20260603182415.2324-3-alifm@linux.ibm.com>
 <20260603163701.2d96ddcd@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260603163701.2d96ddcd@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a20bb56 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pQMbVaZHUEjZWirLrBoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eD5CT704hsRiUpL2Gx_Zr5lu3eezrjwL
X-Proofpoint-ORIG-GUID: eD5CT704hsRiUpL2Gx_Zr5lu3eezrjwL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIzMCBTYWx0ZWRfX79XaLzoTzb1e
 E0pxHq1UqQXzhQ8G1r/O0RdmXg4okKxnkU9+r0iZ2FjLnicN23SBy6G8PtUFfWAxEJk0rAB/fLw
 p/6T9/9cME4Vv0Y1mUjyJ7OxtmDx/rpUMAdEzYlFTSfp/OzI6t3kmqRWBJbKBuU4IdPkJb+cItg
 06Egq6DbSCNTmg8qDZdocHZPK4YCKSRyAmxaLqiqK9Lf7RHv3bMOqbtp0AMK/PJsVWCxGtBTu1N
 HLUTVZRYtJf5QPEFo2QtzZNi9fhz3/RSbeAHtoRNU0WlbK4pP8d9wUAlUN0aZFmU9YX7gOaBhuL
 ovmNo+k38ff++5UYWk63KKWVPCap9eG7+ZypbNraPy/GRwBRDnuoq0kcwHBkS08AN9RlVQpgHaF
 DrmpKDJ0KcCjO/QL04fc1VPLCjGlXhd6PGToRrKtueEfscJm6BKyvebwv+cUBlgVC7G/dS8Wet1
 geI57A5oYjXsFg+Smrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030230
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20467-lists,linux-s390=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:from_mime,linux.ibm.com:mid];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FAC263BE23


On 6/3/2026 3:37 PM, Alex Williamson wrote:
> On Wed,  3 Jun 2026 11:24:13 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..3eead86a00ab 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1534,6 +1534,36 @@ struct vfio_device_feature_dma_buf {
>>    */
>>   #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>   
>> +/**
>> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
>> + * userspace for vfio-pci devices on s390. On s390, PCI error recovery
>> + * involves platform firmware and notification to operating systems is done
>> + * by architecture specific mechanism. Exposing this information to
>> + * userspace allows it to take appropriate actions to handle an
>> + * error on the device. The ioctl returns -ENOMSG if there are no pending
>> + * PCI errors.
>> + */
>> +
>> +struct vfio_device_feature_zpci_err {
>> +	__u32 feature_flags;		/* Indicate future features */
>> +	__u32 reserved1;
>> +	__u32 fh;			/* function handle */
>> +	__u32 fid;			/* function id */
>> +	__u32 ett		:  4;	/* expected table type */
>> +	__u32 mvn		: 12;	/* MSI vector number */
>> +	__u32 dmaas		:  8;	/* DMA address space */
>> +	__u32 reserved2		:  6;
>> +	__u32 q			:  1;	/* event qualifier */
>> +	__u32 rw		:  1;	/* read/write */
> There's a 4-byte hole here.
>
>> +	__u64 faddr;			/* failing address */
>> +	__u32 reserved3;
>> +	__u16 reserved4;
>> +	__u16 pec;			/* PCI event code */
>> +	__u8 reserved5[28];		/* Allow for future expansion */
>> +};
>> +
>> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
> Based on the discussion with Omar and FMB reporting, I don't suppose
> this could also be copied to a user buffer as opaque data with size
> reported elsewhere, could it?  Thanks,
>
> Alex

We currently don't expose any PCI error data to userspace and so 
userspace has no way of knowing the size of the buffer. Unless we 
provide the size, i don't think we can copy the user buffer as opaque data.

Thanks

Farhan



