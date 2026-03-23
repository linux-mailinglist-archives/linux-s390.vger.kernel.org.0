Return-Path: <linux-s390+bounces-17834-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO0uOjkMwWngQAQAu9opvQ
	(envelope-from <linux-s390+bounces-17834-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 23 Mar 2026 10:47:37 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E83D52EF4EC
	for <lists+linux-s390@lfdr.de>; Mon, 23 Mar 2026 10:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1038B30086AD
	for <lists+linux-s390@lfdr.de>; Mon, 23 Mar 2026 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D03383C7B;
	Mon, 23 Mar 2026 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VZ7MnAse"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CBD383C7C;
	Mon, 23 Mar 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259251; cv=none; b=mol04BVzXRdReFoM+wAOR9g5F+gLV1Mo2tcrd3LnUCCN2ToMfcXsKLtCjcsVQYRP6ASY0UawE81DyiXDivFNpOiHBag8yD4+XB6F0MHXJoqT8wp0xu9iAcDVLeAkvgW6B5iof/qOwjXBlTxQRcGl0/uB6FW9VSX1VT3SSrXMj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259251; c=relaxed/simple;
	bh=dg7MTEJDxQeViz5Lc3qAeunkKngD6xaZSQ3OgHws+tI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:Cc:
	 References:In-Reply-To; b=UjcRypcN5i7jv4NokD0O09swacKgqUuCWqhm+FsEH6YZOxxgBUpX++qlAEPCxP7kB4Hrx8XEG7xG0JFqm3GyrEyq3PkOBbwVy1ec92oO+6MRpXI+wMd8pnub6f/A/sSROtct2VdVCy31nXg/Prg22RvwFavV8Hqr6pWEKXNKyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VZ7MnAse; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N8Y5gO2945148;
	Mon, 23 Mar 2026 09:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+8Tgjf
	DIsQbDrZi3stTejsepRdg9sq9CgUbOfUp86xo=; b=VZ7MnAsegkSDSvCj9eCXnV
	L4rrvQwnti5B5QzPMCkrgCkv4RsM3xkkGisoyjHCktrKzj5J6s6z27cU394Ugv/o
	/4UojX3IQEYCpJ4scdD67I2+NAEwSiyaaSbKxaMzl8q4lb48zV8sLjTvV3ljwBzI
	2hMIwThyWvWeU05rTjqG/IIflXGl+2XY6zWnqhHlpFkAAsI39m3VHw47+Mf7Mbyv
	CMAk2ir277opNAT42DOzAeSfYRn6IwG4cLoaYNcK92HutgpmeW1/AKSCffkAP9yu
	GU5DzFqJsSDTZhx6Ezo9nPUWSEEnsY1qw6TEoOTbIYoptK+FhliE0erIqXYTeuRA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktup00x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:47:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N70OM8005976;
	Mon, 23 Mar 2026 09:47:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ycxjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:47:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N9lO8V37880226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 09:47:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C4442004E;
	Mon, 23 Mar 2026 09:47:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A13D2004B;
	Mon, 23 Mar 2026 09:47:24 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 09:47:24 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 10:47:19 +0100
Message-Id: <DHA2EQ7B83MU.19IZL2DDW1XX6@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC 10/10] KVM: s390: Cleanup kvm_s390_store_status_unloaded
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <akrowiak@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-11-frankja@linux.ibm.com>
In-Reply-To: <20260316180310.17765-11-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5ogdO-WjyEDD0_boajmMarFtyX0wPOLv
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c10c31 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=4Ynn71pXNaorYOtORtwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA3MSBTYWx0ZWRfX/yANagsyjOeV
 9WP3gme6UG3MhLk3Mrlg/xjJQy2KjVUGdbfUe+6r7o0hELn8pKLoN95XwbkbAZJqn7y5N5eB2Lq
 7lGO8hrAUYJV5bNYNXyhP8UsgJsrhveAI5Yr5Cf2bRvat9YYiFS7XEJMBvV4+KLb0vAdndoLKgK
 vwHmYtjzJDB/HwXSUNTp3D7fWTON9Cf9aIkxbPtfRxFQ+6QsUIro3yT3TytMw7E94A4MD11TFvS
 iKUSqRPg76JEb32gnEDczg1VCujtI6qjcBh6y4kGHmbDIA533YNKPEH8shCvUo9NEbkLo0py6Sd
 OvLyfu+bdk/rcNoVWbEL1kjgJ2jOYaZ1wMIiL8PzqzO4mmaK++/2ECZnFOCnHxilxktu5Ml3Qyy
 MM5oJGOxvmM3+SjRk2WERVeZYFlozkziLID/S2D7vEYnsPl/z/VkW7WH5ZPbhDZzS2Bgx7/0C4O
 bgqhgVzeBwYErSrbsHg==
X-Proofpoint-GUID: 5ogdO-WjyEDD0_boajmMarFtyX0wPOLv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230071
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17834-lists,linux-s390=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[schlameuss@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E83D52EF4EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 16, 2026 at 5:23 PM CET, Janosch Frank wrote:
> Fixup comments, use gpa_t and replace magic constants.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 24 ++++++++++++++++--------
>  arch/s390/kvm/kvm-s390.h |  4 ++--
>  2 files changed, 18 insertions(+), 10 deletions(-)

