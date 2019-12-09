Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73531171FF
	for <lists+linux-s390@lfdr.de>; Mon,  9 Dec 2019 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfLIQmA (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 9 Dec 2019 11:42:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58683 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbfLIQl7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 11:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575909719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IOIs+T0JPjFAhSLIWFD9VPKRUMGW1/PSSpZsJupmtqs=;
        b=LUxEjHutULu5ynVtuviH+CbM1ssokU5S+9OsI6fDQTDOtCjsQS8M+U36M7gQ6HLuXc6ih5
        EJyxdKpi2by4rbD0an5LfQiPZR9SXwGDsO1zLwGQRAEhhI0YVLCfRN/pk7d3OOZNu1poqz
        xbszjLlddBKIi6BZAB9bxmDsHTTCgz0=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-BZ3m-wXVMmuOP0aiBst_pQ-1; Mon, 09 Dec 2019 11:41:58 -0500
Received: by mail-yw1-f72.google.com with SMTP id l5so1327169ywf.9
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 08:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7O3guB7wOY3MrLnldmdm9BIXXTqe2JfD4cDZWNKwU28=;
        b=uBOMdWpqSbBJN8NtB9haxxAdinm3xaXHG6uq55d+UqR+R6Bd0cCe/jdhuyj/GfE8nN
         7RBk7FagAEBCvZtoc3CODQjFhcVtg87+J2M33yLbHN8VG/qcV/UFDnNAzJdbPB/mARgB
         pAbQD4CVlNaYLpN6tVRoyPhNOOLx5Jy4khCx0Ixzpgr50d+/GgpNCG0146M90f4fth6F
         LKhgI8jXOyGMbksAqSisQFbJFiSG8IjvaxZ1HC1DU/hrQwHscK7Xzb0MfnYtwZ/XZF0r
         EHK78t24+oyytos5lew7f9W90u7j1lprg12PkZV77G6TcOjcrlrA0FEsNXv4bhOcHsaz
         dc5w==
X-Gm-Message-State: APjAAAX+DcB00YD10M44jleEfS1BIo8ik9zRuEa2tvWc7cukcw+5vZ4t
        5W7/V6ShyWPTkhA/HQ8uSSi7pYjzmyqaqc5lm1hiodvK7Pf92ks8R6ywY/+IWGalZ2/Qb9yqil8
        p9aPUL3OL0O+7VeVn0P3VFQ==
X-Received: by 2002:a81:2781:: with SMTP id n123mr22719232ywn.70.1575909717689;
        Mon, 09 Dec 2019 08:41:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/ZUHMqp43x8Abr0QbypV4zplr0Lxd2ECWn2wddcNUn2SzoWt0sz3QIsRsKZxWbketkY9G9w==
X-Received: by 2002:a81:2781:: with SMTP id n123mr22719219ywn.70.1575909717409;
        Mon, 09 Dec 2019 08:41:57 -0800 (PST)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id d186sm144163ywe.0.2019.12.09.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 08:41:56 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:41:55 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: s390 depending on cc-options makes it difficult to configure
Message-ID: <20191209164155.GA78160@dev.jcline.org>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: BZ3m-wXVMmuOP0aiBst_pQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi folks,

Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
makes it difficult to produce an s390 configuration for Fedora and Red
Hat kernels.

The issue is I have the following configurations:

CONFIG_MARCH_Z13=3Dy
CONFIG_TUNE_Z14=3Dy
# CONFIG_TUNE_DEFAULT is not set

When the configuration is prepared on a non-s390x host without a
compiler with -march=3Dz* it changes CONFIG_TUNE_DEFAULT to y which, as
far as I can tell, leads to a kernel tuned for z13 instead of z14.
Fedora and Red Hat build processes produce complete configurations from
snippets on any available host in the build infrastructure which very
frequently is *not* s390.

I did a quick search and couldn't find any other examples of Kconfigs
depending on march or mtune compiler flags and it seems like it'd
generally problematic for people preparing configurations.

Regards,
Jeremy

