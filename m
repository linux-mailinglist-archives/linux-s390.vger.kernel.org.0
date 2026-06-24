Return-Path: <linux-s390+bounces-21237-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fRtWJIDzO2oRgQgAu9opvQ
	(envelope-from <linux-s390+bounces-21237-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 17:10:56 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929F6BF816
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 17:10:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b="Hk/JVCiR";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21237-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21237-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91145300E00F
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0D3D9667;
	Wed, 24 Jun 2026 15:10:50 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B93CDBB7
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 15:10:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313850; cv=none; b=bTEk1lQI2lRZNyYW79R0WQ6Thr4Vnw5QUv/o6KFmVrRb3kJG7E2b9oi0JXQ5nmHLVNeN9+hE+2asGA7u0WnpU07apnUajiQQoJ7MQ8iAY4c4Oo3acZSiUA47rB+Fc/N6SF1kwtDFenlLElgeido1l/zCKj9C8wTobnx2aNJ1l4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313850; c=relaxed/simple;
	bh=4neSC+GBzR6T7ABwyr4E6HCY+dNjOmcTfEGUQcMFctk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPJNZMO6ZEKoHc19U6MRVwArdnpFOWyHFtqjhIN12+gg2klu+2w1bVncCM4LNfg1OwNPUmrFRztW5sRP06oOPo/donHxIT1uo/E4dFVYgB3aJjDJSLkgDv5aB2meZyc32dydcpp9rekagOOWRkWZH1PNFPUlOsqJ8WzjJKkJUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hk/JVCiR; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEmSsI1337386
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 15:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XutJ7r
	pUu40Qu4CXDYPIYhQtuOOY+LuQAyV9olFfZwo=; b=Hk/JVCiRn5V3gE8ryK3Vkw
	1nPHLwd6fO1gGh6OK3GuCIAZFm9nfBpVtmieLk3wJMCKP/IfbPgkFuIYAhQTvoPJ
	PP9b1lhHonuOj9jTQrXc/bI0fSKtTjEWHrlVn0kmAk98RgUdw7Nt7L5sClOhkmIA
	YU+oazL7cORcMIqaCDlxUieoPNC8i6C9nKgZX/C7Wbvwgu0YNKWJsPyQp0UVb9kr
	dF2OdOWfw3WiW6gZDWuyvEN2Fz9lA2C2GgzAg5wmFW9QiC0+nSoBtf3Zm6beneTS
	92uyL3D1aqPHsHmmx2Xzh4FsZ2Ofefqh/17EgYaMq8dy26DVahoSJwEhv8LKEBbg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3mym0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 15:10:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OEoADg004693
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 15:10:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phh5xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 15:10:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OFAhcU12255660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 15:10:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEDD920040;
	Wed, 24 Jun 2026 15:10:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDF032004B;
	Wed, 24 Jun 2026 15:10:42 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 15:10:42 +0000 (GMT)
Message-ID: <72dabfe1-6302-4868-8351-c853a613ada6@linux.ibm.com>
Date: Wed, 24 Jun 2026 17:10:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/monwriter: Reject buffer reuse with different
 data length
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260623174406.189869-1-gerald.schaefer@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260623174406.189869-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3bf378 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pFKB_4Q5YSifCqbc83YA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEyMyBTYWx0ZWRfX+/XeNNKPlvBi
 iRbSkjF/SQ9+57GqfOmw/IZk6OVqATe9USPHgnVDrvCk/SR9xnV+XrkC9hW+gzibRMkqcScKuGK
 YNQGTe1zDxKfTWoir6ymFYW6lSfs56E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEyMyBTYWx0ZWRfX9kgnADp+hH/I
 ito4eUacygUh7YsKrONbZ71Q1snwBwlBSBh6JwvRWy0cr7M5nj39sRuEezvs3uAN6JQ43dz7EzH
 M1BAA2L68r90LAoYQQjRioj8KLvAgMsxgvxymIoCK/KWYSnM752Jp7SHlsB21GNpKIN5wX5G2To
 JAb14YV4d6RMpnSTLmhHAoCZqsIIwxNsl/IItNSgac0ISFkPagCOWnSllBhtKQrTAhX1WsM9KCP
 0zaj9+CBoEi3L319JTn4d1+GIMUPaGmfb6dOaOAkzn+qEgxhKvuCDOrTCiHYAsywUkVSrUOphRn
 7dBfLERFCL5m6ZIdsEIi0SEFXMDJupHhc4rTnkmBDHnHXt+HqkXN2VRfTA5hQAUE1GVVzL7lEa1
 cVe6rVCAq2c8kO9LKyfzj1tttip/VA==
X-Proofpoint-ORIG-GUID: 6pMjIZ5I2_FUXQqcdnDbbrrkCKkMTbMp
X-Proofpoint-GUID: 6pMjIZ5I2_FUXQqcdnDbbrrkCKkMTbMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21237-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:gerald.schaefer@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[borntraeger@linux.ibm.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[borntraeger@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1929F6BF816

Am 23.06.26 um 19:44 schrieb Gerald Schaefer:
> When data buffers are reused, e.g. for interval sample records, the
> first record determines the data length, and the size of the buffer for
> user copy. Current monwriter code does not check if the data length was
> changed for subsequent records, which also would never happen for valid
> user programs.
> 
> However, a malicious user could change the data length, resulting in out
> of bounds user copy to the kernel buffer, and memory corruption. By
> default, the monwriter misc device is created with root-only permissions,
> so practical impact is typically low.
> 
> Fix this by checking for changed data length and rejecting such records.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>



