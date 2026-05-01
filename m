Return-Path: <linux-s390+bounces-19266-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEGfM0Xf9Gn8FQIAu9opvQ
	(envelope-from <linux-s390+bounces-19266-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 19:13:41 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE804AE6AE
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 19:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DDC3300ECBB
	for <lists+linux-s390@lfdr.de>; Fri,  1 May 2026 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F753DEAE0;
	Fri,  1 May 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX2L1x4x"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E7304BA3;
	Fri,  1 May 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655380; cv=none; b=JJMCQD2NKarrgogZmYW8Dnk8Hwq3VdXCo34P+OT5eUqQw+6kNnEVmV+CGaoL7wL56A4l05egnRa3p3RfCpVAA+5w9kzrOTfvOmN2vMHJNNQ7ocKNXvTxDgC6uPxtWssciyljtaFFDZJXVDDMlZcjJaZ3Qm0NUSCYyus0WEhCpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655380; c=relaxed/simple;
	bh=aCKpiD8Crlk0uEQZs9vyjBCgLqxVn32/cxl6Y0AtRGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9QVSJ7t4UuIyGRQghAiPg4gHA0vtJ7rUlLq29jCbGfmuGdaD+5ob5fHVGaLJlcBJ0hkmF9JxSzhTmUyXGnDNnsOcbzjdjzEKXh9hJPc63TvbjrV4jv/RCuYbSi1rHo/QGLk1DFl2BCQBAzz+zDCURUBSi+yvQg8ILLILlpzpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX2L1x4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC2AC2BCB4;
	Fri,  1 May 2026 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777655379;
	bh=aCKpiD8Crlk0uEQZs9vyjBCgLqxVn32/cxl6Y0AtRGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OX2L1x4xFIxbScfPDUbir6mmS+xdX9NmUYzJR0EJkE7ri86qbaeUTkDb4jWI5oeb+
	 aN4JbRR+N5UIrCNNa22w2pCZ2JSMSHoSZwNy2T2qFiVEenmDxH9tkupv+ZDyGU2ObI
	 654hr8gYpcXDtcmeRIPh1KdMIPoWk95vpdUy3GSPXi4IHKF8A7wxn55TDFMfm9T3X7
	 2RVfuwK5n/jkaekIr44u2S02mSaPb7gcycVdlcOtlmx86ngcN1rcmImzOHzRA44jyl
	 l2G+a79TnBeaUy0DKnFo0u2dmfaqSvsLz/R2tzsXHpnuJk6XOz3vggn1h43+SNrKA+
	 0+Ne8WhoVmpcw==
Date: Fri, 1 May 2026 18:09:30 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Barry Song (Xiaomi)" <baohua@kernel.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz, 
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afTeKp90wGNixIOX@lucifer>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <afTKsSj0i-ZkRZN5@lucifer>
 <afTPamwDbtY_tgk_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afTPamwDbtY_tgk_@casper.infradead.org>
X-Rspamd-Queue-Id: 3AE804AE6AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19266-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,kvack.org,infradead.org,google.com,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, May 01, 2026 at 05:06:02PM +0100, Matthew Wilcox wrote:
> On Fri, May 01, 2026 at 04:52:12PM +0100, Lorenzo Stoakes wrote:
> > After a brief eyeball I share Matthew's assessment, I really don't like this
> > series, it's piling on complexity for what seem like niche cases.
>
> I don't think they're niche cases ... I think it's a real problem.
> While our current code performs better for this workload than the
> pre-vma-lock code did, it doesn't perform as well as it could.
>
> > We already have enough weirdness in fault code honestly.
> >
> > Let's maybe discuss at LSF if you're attending?
>
> Not only is he attending, there's a topic scheduled (currently 10:30 on
> Wednesday).

Well then, let's revisit this in person in Zagreb :)

Cheers, Lorenzo

