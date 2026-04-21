Return-Path: <linux-s390+bounces-18958-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eABKAfCw52lZ/QEAu9opvQ
	(envelope-from <linux-s390+bounces-18958-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 21 Apr 2026 19:16:32 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C2F43DD08
	for <lists+linux-s390@lfdr.de>; Tue, 21 Apr 2026 19:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B82583033489
	for <lists+linux-s390@lfdr.de>; Tue, 21 Apr 2026 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A90364931;
	Tue, 21 Apr 2026 17:13:37 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5C2D97B7
	for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791617; cv=none; b=Uebq9kzgVZqQWpisbpuU4QmbqxUh/CwOlx7QZ1uFG89HP5KaNCX4CF9/DbxWwDUeyTPpB4rtoxnOF6fQBfAXe3thw7pucPs+7ZZNQoGN7v+/tNUARAT9uBOgHtCRWlj7K5a/kdoY3qbU4guzXSdt2am9r16Rv2CqfN7Fz5fRU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791617; c=relaxed/simple;
	bh=dNPqhdaCExXnqljjtmyEiK2FfGUZQrh5olPv++EE6Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otAn3o8Yp8qtnoDlu6HTxf+qCvVjgyr7+BGR+OEn6xFdVTt3L08Lse+qzLPPkyLfsoIkPqsfqV1eNNXcWBF4JxzEyFrqCDys2hqGFsxweTJZruZYwYCiHrQD4FDhI+Nq5rABqQrf4lxnj3H8118JEOwR3fUQ0g+3y5CIibxp6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aaed195901so19769215ad.0
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 10:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791616; x=1777396416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOptXCQFoecDGSEMq5oXbgb/TQScxdLgsFvp93S1GiI=;
        b=WWthkvhPh+yN7iAuAzYC69dtmF3KXhVWd8SAEP2q+eforTeMUJefATH4zhhAQOe1gQ
         UisarZpAc+znq5VjiUg3g+CrIt7AeBIGT4mg9cMLNJXC+wzbHmKPMkG57XunGgvliEtI
         eYbpBxKlik00GTI5sPG2SUtSpmqnnIPUe34nH7H3sFTLL+3xMh/QTS3p7ODZ66FYybbA
         C5oUOajSXz/VK36DfLlyKGKBB0Q0BkwFHTnV+Rz7h1SL6NAGZSEsWn8pkJql3FFqY2lP
         Hc7W6Hcojq+X67NAZbIb+mP4J/K7c4KpDc3XO62jjen17Q8OE7B8xHrBmGaNHrY9bFnS
         3QCg==
X-Forwarded-Encrypted: i=1; AFNElJ9HnKhcDsHfv620aPxqOTpuF/W7EH1rr3W4XUR2XLTQdt7hElnGFmLdOEbeIYfbPshC2yIMDjmCL/Bd@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBzf/u1JLeLieXitLiyhIg8/2L2Z/QvLqS1yL/16XYzHqQ5xQ
	UvERjD2uWGFJMRE6fNSUMVA4YhxmK3Cz+KOwm9CohGnTELB6fZqcwkJG
X-Gm-Gg: AeBDietHa1oJCG4nf1fsEcFyrfbF2gvuJH1nrWN6KZh3lKO/KmypHVOocLw5e+ITBTW
	0I+TIRKREvOR0EfCdhI1KizBHc1XP9iLc+V0sLbOuRiTXbW1cNUp0QjoHir3WdhhVivxQ+PuB86
	GULjlHdSQQXxTZvyF0aZ/jcOkOdkHtGuc1z6DO1uk6RK91P5W13tE/dRzEBONBajHPgvNuzXN6B
	aHEJLFii7/CbXnG9+ON+HhLtih04g+jG0HqoPHI4RaMmYrY2UkXwYhzy+IMurP40QUx3tgvNODl
	9w0+7cHIF7wYafn4A5XrdcFIOwD38IXjD1rvsOsBSl79vaIZXZD44CPhG45aqxBeXHScFST3Tu9
	aFyoAO6y1YgaiZhJksoLqMhyaFdVXbOi9zUVATqvDJ6GuBzDtOUKVQIwxsGmkrCTB8240VIng4i
	z3RsX+d1+mlZc1qf/wE5oIpy6WQ4bO+mlG18Ha0lz6uQiCjzt99Y+EkRpULeJE6padhpO3ZjHw2
	D3DUBjyIlW4OWLTKXRYlf9T02Q1Ph1z/r4m6hABACXnRYB62ACn2ZV8ntjEqmOFxmBh3nk5JPtT
	rXItQWq9MbYPH9ioY7ovPhu7c2fsbSzF2p25GUQTbg==
X-Received: by 2002:a17:902:bf4a:b0:2b2:4e5c:69a9 with SMTP id d9443c01a7336-2b5f9e79fa8mr145008315ad.5.1776791616146;
        Tue, 21 Apr 2026 10:13:36 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff713sm142070275ad.5.2026.04.21.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:13:35 -0700 (PDT)
Date: Wed, 22 Apr 2026 02:13:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
Message-ID: <20260421171334.GA1684602@rocinante>
References: <20260416213909.705753-1-ramesh@linux.ibm.com>
 <20260416213909.705753-2-ramesh@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416213909.705753-2-ramesh@linux.ibm.com>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18958-lists,linux-s390=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kw@linux.com,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09C2F43DD08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

> +static struct pci_slot_attribute hotplug_slot_attr_uevent = {
> +	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
> +	.show = NULL,
> +	.store = uevent_write_file
> +};

I think, you could use the __ATTR_WO() macro here.

Thank you!

	Krzysztof

