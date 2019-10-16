Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB86D935D
	for <lists+linux-s390@lfdr.de>; Wed, 16 Oct 2019 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbfJPOJi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Oct 2019 10:09:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35520 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfJPOJi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Oct 2019 10:09:38 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so22872146qkf.2
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbLFFtj39kkBf5dkql9MHXopp0F39M0Fqhm7mWy045Q=;
        b=hYNlRyNg8vFkPzQVjv108oF4X8imWdsQPeb/8uXTjEjUOy2It0rTxwvHdKZRnbWsPU
         J59C6GVORFOefgDVmVnjQ2ZaIWKqY57UT+V8TKW/gyo3/fd5onIlYYDS1Eo9oQfLZxcL
         D7J2kgXHUaF68hu6JZXtoQa0NwkrIJaQcNH11dPZWTJjpYudzSFkPAwbn3d20DWx/7Bf
         0rQgUlwzXXdWD4GAc+DepazemS/sWxYAoCKeNO/UZ593WshwWTPyYgSRmndPfLtOo8OI
         LHWu72OE5xIRuhFV3RVQ8Go+/THXlgYZWQ8I5knmow52XH6LpW009GTtXPrguFNOCuur
         dO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbLFFtj39kkBf5dkql9MHXopp0F39M0Fqhm7mWy045Q=;
        b=tgWiATGGRLriJ88D1oU1E4WOUIEQusY4KtQEXVoz2jfwZYXcGfZO+Y9gTS3CpQYhuV
         sqvOuuheOHYGDUbk+So0cKRs8cd6HjGrItk/91MFiWiKO6dGPNwtgL6EivTYpyO35RS4
         Whsk8Gnpy8TxgOShJDVzFnMTC29OLvJFBFVVepOnDJqwLk0W2ocjSD/7TUMxRl7Im31D
         RUn9YecFmgPrfy99IjCfxTNjxaflabQ5V9i1tHzaI7Zdcahb59a18+tm2vqQFT+UwIb8
         cgvA7huX3u5S6EUPMFNa6323bxmh9ynSEc9HkHEH/rfOAX5bQiMgrEOoSKRNyaFDnn0O
         K+cw==
X-Gm-Message-State: APjAAAV0GuRtjqmosObxGwMhMOEZqNIYF5syf96MZdj+LUUuq4Z4YENN
        2X6tC5XcMQrzcOEJDmvEiSnSBA==
X-Google-Smtp-Source: APXvYqyklEz5e4+IwFGQBrBmCZvd+42WiJ1q+u4q7+b33ayLkLa/ZT1Zr72zVQg0+mStrEfooLIkiQ==
X-Received: by 2002:a37:4bd2:: with SMTP id y201mr41517861qka.391.1571234976882;
        Wed, 16 Oct 2019 07:09:36 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x12sm15910012qtb.32.2019.10.16.07.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:09:36 -0700 (PDT)
Message-ID: <1571234974.5937.53.camel@lca.pw>
Subject: Re: memory leaks in dasd_eckd_check_characteristics() error paths
From:   Qian Cai <cai@lca.pw>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 10:09:34 -0400
In-Reply-To: <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
References: <1570044801.5576.262.camel@lca.pw>
         <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2019-10-16 at 15:29 +0200, Stefan Haberland wrote:
> Hi,
> 
> thanks for reporting this.
> 
> On 02.10.19 21:33, Qian Cai wrote:
> > For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
> > dasd_generic_set_online() emits this message,
> > 
> > dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12
> > 
> > After that, there are several memory leaks below. There are "config_data" and
> > then stored as,
> > 
> > /* store per path conf_data */
> > device->path[pos].conf_data = conf_data;
> > 
> > When it processes the error path in  dasd_generic_set_online(), it calls
> > dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
> > the device->path[].conf_data first. 
> 
> Usually dasd_delete_device() calls dasd_generic_free_discipline() which
> takes care of
> the device->path[].conf_data in dasd_eckd_uncheck_device().
> From a first look this looks sane.
> 
> So I need to spend a closer look if this does not happen correctly here.

When dasd_eckd_check_characteristics() failed here,

	if (!private) {
		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
		if (!private) {
			dev_warn(&device->cdev->dev,
				 "Allocating memory for private DASD data "
				 "failed\n");
			return -ENOMEM;
		}
		device->private = private;

The device->private is NULL.

Then, in dasd_eckd_uncheck_device(), it will return immediately.

	if (!private)
		return;

> 
> > Is it safe to free those in
> > dasd_free_device() without worrying about the double-free? Or, is it better to
> > free those in dasd_eckd_check_characteristics()'s goto error handling, i.e.,
> > out_err*?
> > 
> > --- a/drivers/s390/block/dasd.c
> > +++ b/drivers/s390/block/dasd.c
> > @@ -153,6 +153,9 @@ struct dasd_device *dasd_alloc_device(void)
> >   */
> >  void dasd_free_device(struct dasd_device *device)
> >  {
> > +       for (int i = 0; i < 8; i++)
> > +               kfree(device->path[i].conf_data);
> > +
> >         kfree(device->private);
> >         free_pages((unsigned long) device->ese_mem, 1);
> >         free_page((unsigned long) device->erp_mem);
> > 
> > 
> > unreferenced object 0x0fcee900 (size 256):
> >   comm "dasdconf.sh", pid 446, jiffies 4294940081 (age 170.340s)
> >   hex dump (first 32 bytes):
> >     dc 01 01 00 f0 f0 f2 f1 f0 f7 f9 f0 f0 c9 c2 d4  ................
> >     f7 f5 f0 f0 f0 f0 f0 f0 f0 c6 d9 c2 f7 f1 62 33  ..............b3
> >   backtrace:
> >     [<00000000a83b1992>] kmem_cache_alloc_trace+0x200/0x388
> >     [<00000000048ef3e2>] dasd_eckd_read_conf+0x408/0x1400 [dasd_eckd_mod]
> >     [<00000000ce31f195>] dasd_eckd_check_characteristics+0x3cc/0x938
> > [dasd_eckd_mod]
> >     [<00000000f6f1759b>] dasd_generic_set_online+0x150/0x4c0
> >     [<00000000efca1efa>] ccw_device_set_online+0x324/0x808
> >     [<00000000f9779774>] online_store_recog_and_online+0xe8/0x220
> >     [<00000000349a5446>] online_store+0x2ce/0x420
> >     [<000000005bd145f8>] kernfs_fop_write+0x1bc/0x270
> >     [<0000000005664197>] vfs_write+0xce/0x220
> >     [<0000000044a8bccb>] ksys_write+0xea/0x190
> >     [<0000000037335938>] system_call+0x296/0x2b4
> 
> 
