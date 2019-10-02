Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FDAC9269
	for <lists+linux-s390@lfdr.de>; Wed,  2 Oct 2019 21:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfJBTd1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 2 Oct 2019 15:33:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44484 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBTd0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 15:33:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so16236925qkk.11
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=vC99SaJEojFpNSx9KA2t2PR97mfI8j+nfD/zaFcYgk8=;
        b=JYh8Db+2QTBY9rKv5L25450HMvrJjFA2tYqCwFDaszPOQDRaANQ9TkqgFL1MhfgPJ+
         C98NdRhYduhWEQil4UzG+el8NGez7EaIqslNx+xy9owBLsZc8AbvIn2QRqUjimnSVBxn
         qbjJhLOn7YjDar0133MpbxFRt4XsXM6eRTs2C3a/KIVBfIUZdIo8Rupzm1s6YEMKQuQo
         uWeNI4ZhoP6+3+5v0ldelLcgykAfwMNdLmXC4Q1jKxTt02Y9Ki9b0lXrLL9fuAyq5y4M
         DknFhN7TJx6uR0n/VDB3H/OINuRofSm2uV2JT7/PrNsUYCHbe1ftpDrn1djKqjfl2Dio
         dM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=vC99SaJEojFpNSx9KA2t2PR97mfI8j+nfD/zaFcYgk8=;
        b=AGlmmkO9hCxOdlN+E+YQmpw6eoCPa/sJWpHRgoWtD627b8pq+HSc13knoK5msJoajr
         E9sEvRfjuUlFzlHAkYenqA7Rrd06KxWQ2cXim2hyGVBlivkqWhi25aAi0WqBcaVnDHVX
         Vs2x+2gXUAp2UbSHkXpFZWC7h8y+hXfGUOIDweGTSuZC7MGEsUhKpg0m0UwRHjBSDww0
         WqNdJ7FvBNa7DjfoONgcIGOw9l3rqiVw7hVrN2iQnRxBEHexqjc51rQw0seQf7N2HtLy
         YhfCYRn9AtoFf7kDWYRL6z9s/sZBY2fTzW/zncm/EkkgbWFIUlBsTb8Wvw16flb8K/xu
         l/bg==
X-Gm-Message-State: APjAAAXff9z7FDAVrJ98VYEuu60UJqDW6FTUhnDFqhsMMBwySXL1ywqb
        UmLXXy68+Ua561r9ugZPmhFXzg==
X-Google-Smtp-Source: APXvYqxPp6gdC4RYIABsqCcymYFIXs3Xolh8BO7qCvOBUjC+VQw30JHxCyutLj8ijAq6UEv2W3vJHg==
X-Received: by 2002:a05:620a:13c7:: with SMTP id g7mr460370qkl.21.1570044803983;
        Wed, 02 Oct 2019 12:33:23 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z72sm61363qka.115.2019.10.02.12.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 12:33:23 -0700 (PDT)
Message-ID: <1570044801.5576.262.camel@lca.pw>
Subject: memory leaks in dasd_eckd_check_characteristics() error paths
From:   Qian Cai <cai@lca.pw>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Oct 2019 15:33:21 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
dasd_generic_set_online() emits this message,

dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12

After that, there are several memory leaks below. There are "config_data" and
then stored as,

/* store per path conf_data */
device->path[pos].conf_data = conf_data;

When it processes the error path in  dasd_generic_set_online(), it calls
dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
the device->path[].conf_data first. Is it safe to free those in
dasd_free_device() without worrying about the double-free? Or, is it better to
free those in dasd_eckd_check_characteristics()'s goto error handling, i.e.,
out_err*?

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -153,6 +153,9 @@ struct dasd_device *dasd_alloc_device(void)
  */
 void dasd_free_device(struct dasd_device *device)
 {
+       for (int i = 0; i < 8; i++)
+               kfree(device->path[i].conf_data);
+
        kfree(device->private);
        free_pages((unsigned long) device->ese_mem, 1);
        free_page((unsigned long) device->erp_mem);


unreferenced object 0x0fcee900 (size 256):
  comm "dasdconf.sh", pid 446, jiffies 4294940081 (age 170.340s)
  hex dump (first 32 bytes):
    dc 01 01 00 f0 f0 f2 f1 f0 f7 f9 f0 f0 c9 c2 d4  ................
    f7 f5 f0 f0 f0 f0 f0 f0 f0 c6 d9 c2 f7 f1 62 33  ..............b3
  backtrace:
    [<00000000a83b1992>] kmem_cache_alloc_trace+0x200/0x388
    [<00000000048ef3e2>] dasd_eckd_read_conf+0x408/0x1400 [dasd_eckd_mod]
    [<00000000ce31f195>] dasd_eckd_check_characteristics+0x3cc/0x938
[dasd_eckd_mod]
    [<00000000f6f1759b>] dasd_generic_set_online+0x150/0x4c0
    [<00000000efca1efa>] ccw_device_set_online+0x324/0x808
    [<00000000f9779774>] online_store_recog_and_online+0xe8/0x220
    [<00000000349a5446>] online_store+0x2ce/0x420
    [<000000005bd145f8>] kernfs_fop_write+0x1bc/0x270
    [<0000000005664197>] vfs_write+0xce/0x220
    [<0000000044a8bccb>] ksys_write+0xea/0x190
    [<0000000037335938>] system_call+0x296/0x2b4
