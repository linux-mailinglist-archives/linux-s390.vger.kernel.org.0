Return-Path: <linux-s390+bounces-20596-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sVZXLpjSJmp9lAIAu9opvQ
	(envelope-from <linux-s390+bounces-20596-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 16:32:56 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D6657395
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 16:32:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=iPAlOA1S;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20596-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20596-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46B530356C3
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2026 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C7F270EDF;
	Mon,  8 Jun 2026 14:21:46 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BB3C584A;
	Mon,  8 Jun 2026 14:21:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928506; cv=none; b=E5bm4ms8qgTI+JkyPxOTyGe8vG0cLJgSORE6rXYeF6BZm9TNtRHkzKnA6BASF57OnYGXBaEFSNz+tisvzHg/yaZPcg7fQKrCANbsSz6R+r4tt+QK4ywJqI/j5CKkDZqGc+rvm5N0e6EICVgfiesLbuf2YahWhUg2a02ugma6up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928506; c=relaxed/simple;
	bh=YshRppDmEmPLc+baG7I1l/5SpGS1QkJmyys3cszbdo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPqbNk1vF5tA11sqB3k0dlrRB9HV/qic2xhx2aED1PYKx0VZgXCqupww5YLukf3T2ObJKDCZV1oxvhPM1FYALpyb9PjXzFwJvlJffV0WUq+rBtrGsFpX8cAdSbEWPD+n3vXI1EZkQX+/AGwff6t1NgbHy5HCFhN+ZoxIk+/Z9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iPAlOA1S; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NfGnT4023506;
	Mon, 8 Jun 2026 14:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=t6qCZOts6bpbcFs80dV/XvapzOJEQQ
	YHofkNd3249IU=; b=iPAlOA1S2aAdHLdI0QpJj4xHKVAD2vdkBWV+sj3csirqiz
	+gw7QNdaAGfuCH8TU/8orUfHsm8WiO6V1lLfZPvFDMIrsolvpvA+Q3ZaZB1Ua6BI
	s55JzymuUSQNGwNYVe1WFqN7V0Z9jfMhh9T/kzSer9sDJcGwlJ60WWHECJ/yczyK
	vxeXKiV95w8DstiJgc2o8hZhpbjW+WGwv69ndJYw4LbTkW8Wq4KbPV8wqQodTxwU
	5MD8pnre4jjJ7tjaXuH6pAmo7QD1aDSS+/GwiVpsfzmVPr/f1XMcUgtXTi5dgFPp
	6NtFMJAyk3fyq2HP80NtMgDV5RFj5MV8clkmZ9qQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sqj6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 14:21:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658EJiIi017137;
	Mon, 8 Jun 2026 14:21:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fwf0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 14:21:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658ELPcP32964978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 14:21:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55E5320043;
	Mon,  8 Jun 2026 14:21:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3222320040;
	Mon,  8 Jun 2026 14:21:24 +0000 (GMT)
Received: from osiris (unknown [9.111.82.157])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 14:21:24 +0000 (GMT)
Date: Mon, 8 Jun 2026 16:21:22 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Jan Polensky <japo@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, ojeda@kernel.org,
        peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        aliceryhl@google.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
        lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
        dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org,
        linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] s390: Enable Rust support and add required arch
 glue
Message-ID: <20260608142122.34400J00-hca@linux.ibm.com>
References: <20260601174625.2910233-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601174625.2910233-1-japo@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dEqGWTeCzNGp4n6zVjjQXzPNL0DchhPN
X-Proofpoint-GUID: 587XZlgGNBKoJ15LAMb1BovEPwDXRFfd
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a26cfea cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=qU4AmLuwZyk7mJCWj2MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzNCBTYWx0ZWRfX0weW4MTkKtSz
 0kSjSip2p4qooWC1T44hrlLxMX0/ZtfQC7tEveh7lclmh5rb4TVh59EqJ6fieO/qaUvDNfjlzsL
 Pl6nYbfMak2sBAkoY329ISN2roxGarmu8LCyfjRZuhmToQsa65gUP7mD3OCqLxcORDILVfwBR/Z
 l4mNugtEJmBhZueE1/B28BShZFLdLW2sK/Wl3803iGfnGLEVkI3C2Vpp24AdYGHv4J6U2vS6sEV
 mts0vQ/Sxb73BiaX6HlGQ5yYdgJ6ZR49vml4lIx1L3SgTUDgt+fTXmMsm1QAAC09Vmxrca629It
 VT6eejEPY7h6pA/hFh3dfwNbQU1QkPOusRFGIfMP8ogwSVqe1/BabDMTFI+UVWa9p73jOZOvYSn
 tvbjEpC3zg76uiQZMfjSoRf4O8mEULW6RigrrI5mD0x021DvgLQz4YDtCmAU7jfGdsJfAnwYQ0q
 +JtUSQdBvYSHNk3scPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080134
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,infradead.org,akamai.com,google.com,garyguo.net,protonmail.com,umich.edu,goodmis.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20596-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:japo@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:ojeda@kernel.org,m:peterz@infradead.org,m:jpoimboe@kernel.org,m:jbaron@akamai.com,m:aliceryhl@google.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:rostedt@goodmis.org,m:ardb@kernel.org,m:linux-s390@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 134D6657395

On Mon, Jun 01, 2026 at 07:46:19PM +0200, Jan Polensky wrote:
> Rust support on s390 requires a small set of architecture-specific pieces
> before the generic Rust kernel infrastructure can be used.
> 
> The series wires up s390 as a Rust-capable 64-bit architecture, adds the
> missing assembly interfaces needed by Rust for WARN/BUG reporting and for
> static branches, adjusts bindgen parameters to avoid repr layout conflicts
> caused by packed and aligned s390 structures, and fixes issues discovered
> during testing.

...

> Jan Polensky (6):
>   s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
>   s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and
>     ARCH_STATIC_BRANCH_ASM macros
>   rust/bindgen_parameters: Mark s390 types as opaque to prevent repr
>     conflicts
>   rust: helpers: Add memchr wrapper for string operations
>   s390/cmpxchg: Fix KASAN stack-out-of-bounds in atomic helpers
>   s390: Enable Rust support
> 
>  Documentation/rust/arch-support.rst |  1 +
>  arch/s390/Kconfig                   |  1 +
>  arch/s390/Makefile                  | 28 ++++++++++++++----------
>  arch/s390/include/asm/bug.h         | 12 +++++++++++
>  arch/s390/include/asm/cmpxchg.h     |  8 +++----
>  arch/s390/include/asm/jump_label.h  | 33 +++++++++++++++++------------
>  rust/Makefile                       |  1 +
>  rust/bindgen_parameters             |  7 ++++++
>  rust/helpers/helpers.c              |  1 +
>  rust/helpers/string.c               |  8 +++++++
>  scripts/generate_rust_target.rs     |  2 ++
>  scripts/min-tool-version.sh         |  6 +++++-
>  12 files changed, 78 insertions(+), 30 deletions(-)
>  create mode 100644 rust/helpers/string.c

Thanks a lot! For the whole series:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

I guess Alexander will pick this up and route this via s390.

