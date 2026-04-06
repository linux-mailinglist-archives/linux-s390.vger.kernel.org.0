Return-Path: <linux-s390+bounces-18535-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHl/CaRG02meggcAu9opvQ
	(envelope-from <linux-s390+bounces-18535-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Apr 2026 07:37:40 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9903A19D9
	for <lists+linux-s390@lfdr.de>; Mon, 06 Apr 2026 07:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DDA53003703
	for <lists+linux-s390@lfdr.de>; Mon,  6 Apr 2026 05:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC7315D46;
	Mon,  6 Apr 2026 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4Q97rkte"
X-Original-To: linux-s390@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B7830F7F3;
	Mon,  6 Apr 2026 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775453853; cv=none; b=YsJ0/nh6tRt9nwsAsQTfpNudEb9trCTJ7GCPEXXEm6SA5GrgiOZsnARqFz/ouq62qhENL3zW6seFGEnzx8sNyy7eD4iE5/3OkLZvWd2WrEEZtuPqVgGfL3K7YUjbmP2sgCdFaRnGnKngHfqJh+7XsWEJ2ogxaNow2bnK5tItxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775453853; c=relaxed/simple;
	bh=3H7RsowI2ljlCeNQo2yEaOqoIoLG6qEMEjbd4gFPCAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4JJLfOUsCBn/rKIkErsNNwDcS9gOMwXkIYNxz3JFWbQhJ9q7qzl+tPBY6DadvEcKG7l1Q4fximjqdW40aSh3OEyUfZWGo8gX3orrSrQMUOLXo+LjEn1GjYQEtU6koT8XnI1hFYHj94EbmJKMwmh3mHHp+SUvhG+pCNZy85BCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4Q97rkte; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pbhmUnBc+LFMvDuylockDJOhrvEN4yYtm4qtLcRwpFA=; b=4Q97rkteH2M8VqUr9K7iJpDsKi
	8Yc//EWBPDpGzC15+FA6pjKLjYcYgYAv3M1hlnq8Df3Orza0UTQli1WcXhDtpOVEUis/Z8z4JLdqL
	kQNx/Dm2cC1q3RDWJ82c38FLRVG47eV+JmsW02NJmsVDufq0y/+9Q2MY8KdTq1OkHUahut707fLr5
	k2QW4yJ4BF/s+HhC+pAyZc95zVJwT7lszndPATL9qgZCs1RuhINKSDu2CT5+f8Rbe9wGV8zWnmjNg
	K6Vd9N+UzCQYIJyoFg0lhP5UGSE9MUQ2hSr1jPsain2hreScZP1W2UHcDnnSfvbA4HWarUMm0JBF6
	mVRLKwOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9ceP-00000004oY7-0koH;
	Mon, 06 Apr 2026 05:37:29 +0000
Date: Sun, 5 Apr 2026 22:37:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Farman <farman@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 0/4] KVM: s390: Permit ESA mode guests in VSIE
Message-ID: <adNGmUzxx5OCK69e@infradead.org>
References: <20260401020915.1339228-1-farman@linux.ibm.com>
 <acy98BMq0BoqWPn3@infradead.org>
 <bbd43c25-b624-4e23-8870-6116532316a8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd43c25-b624-4e23-8870-6116532316a8@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18535-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A9903A19D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:00:59PM +0200, Janosch Frank wrote:
> KVM is the latest hypervisor in a long list on s390. As such we implemented
> the newest architecture as our starting point and only architecture
> (zArch/64bit).
> 
> There are others which don't start their guests from zArch mode but start
> them in ESA and slowly move them through modes until they reach zArch. Those
> other hypervisors often implement emulation for features and devices that
> KVM doesn't support so there's some demand for using them.
> 
> Why do we nest those hypervisors under KVM? We have products that work with
> the KVM API so it's easier to nest than to re-write the product to use other
> hypervisors in the first place.

Makes sense.  Maybe mention this in the cover letter, and also that
you're not looking into full device model support for older systems?


