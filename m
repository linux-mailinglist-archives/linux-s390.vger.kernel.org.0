Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A563A42
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jul 2019 19:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfGIRpd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 9 Jul 2019 13:45:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34496 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGIRpc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jul 2019 13:45:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so10478163plt.1;
        Tue, 09 Jul 2019 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FuOqUVUpQrBR59LmIrjEFPzqVKP8OL1hHgCATx9jRI=;
        b=pp61QyJzRLHPykvMD7CM0HWxYQ5+4QT4EWebdjIJs9a+/t7dvLmwa5hQxw6hxoPm0z
         HDDnxwPfrUw6dqJpnjaIe1vH8CJFnMWietpaIf+Yfp1abvDXUmYlpiBzLjeYl1rxYDiZ
         wsu/XJl9+L1KcGGGA3PkRbdUmdIfH7xlU/JFmtSr19UC7PJdJ3OTtrYmQ1UnXTRI3zUZ
         /9h2RbyJkCa072l63RF7YjkPuWkEFSDDSaXsHN9lmdwn6AlabqH1ibdfoOZawGSVRbCE
         XPtsAqSa0pTsViBqCNfLuYWMshGbN6PfhgYyvS5q6uydnU7QYevKDa6iodv2NVhvrYMo
         ULzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FuOqUVUpQrBR59LmIrjEFPzqVKP8OL1hHgCATx9jRI=;
        b=PkkRrrOO4Okhwp3UkQUllYTHsSFTdG20C/UmrbwEBIeHlr6GNyOaEUK5hSq+leIAvb
         P5Tp/ivHe4oaS7uAiQ5nQnsyDrkXdUgTPUAGu7YWnbbmIZcPRBp4RFny2vilc4z1/Ldy
         pKsdOwwnWUjQSWNzhGDNF0WRu0AlHUjOS8PN+puKJXL0yJ7XjMIY3mXyPKxVgKGnDqvx
         w6ADPiVZkTUZzcvQ94qg/GXOhZPNQamPyjU9GBgQCGxklVnXyRP8p1zR59vg80JgKX2V
         NsgQMA3hthCRsRo2CU6uGDx7zkBpyFmLL2hgTn7I29ILJpF+hyfHjbpoa6/SOZV42+FL
         /YJQ==
X-Gm-Message-State: APjAAAV2i1pQqcuJXimTvk2xTWJctIx5RBWAaBuJmpEUuMIlM00NvROP
        SpBiMEZlAEEW7gVKZ7Z8vxc7a3i5j2aGqmlXInE=
X-Google-Smtp-Source: APXvYqxEPTfgHb26Zho3QRrfYxCRzu5kADgBKOwD1IQ5GSGcQ6/zdUsDGGueMRw5EhZu5kqXQiVwk1bjyW9VB6T1SGE=
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr33364326plt.255.1562694331915;
 Tue, 09 Jul 2019 10:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <925686792c61b584f05dd9f13f078cd82d5b6a54.1562674354.git.mchehab+samsung@kernel.org>
In-Reply-To: <925686792c61b584f05dd9f13f078cd82d5b6a54.1562674354.git.mchehab+samsung@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Jul 2019 20:45:20 +0300
Message-ID: <CAHp75VdHhOuJAOHbJCbp486DYHtRAN-k-MQPt9EGHuGOUasrdQ@mail.gmail.com>
Subject: Re: [PATCH] docs: don't use nested tables
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 9, 2019 at 3:12 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Nested tables aren't supported for pdf output on Sphinx 1.7.9:
>

>         admin-guide/laptops/sonypi:: nested tables are not yet implemented.
>         admin-guide/laptops/toshiba_haps:: nested tables are not yet implemented.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>         driver-api/nvdimm/btt:: nested tables are not yet implemented.
>         s390/debugging390:: nested tables are not yet implemented.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/admin-guide/laptops/sonypi.rst  | 26 +++++++++----------
>  .../admin-guide/laptops/toshiba_haps.rst      |  8 +++---
>  Documentation/driver-api/nvdimm/btt.rst       |  2 +-
>  Documentation/s390/debugging390.rst           |  2 +-
>  4 files changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/admin-guide/laptops/sonypi.rst b/Documentation/admin-guide/laptops/sonypi.rst
> index 2a1975ed7ee4..c6eaaf48f7c1 100644
> --- a/Documentation/admin-guide/laptops/sonypi.rst
> +++ b/Documentation/admin-guide/laptops/sonypi.rst
> @@ -53,7 +53,7 @@ module or sonypi.<param>=<value> on the kernel boot line when sonypi is
>  statically linked into the kernel). Those options are:
>
>         =============== =======================================================
> -       minor:          minor number of the misc device /dev/sonypi,
> +       minor:          minor number of the misc device /dev/sonypi,
>                         default is -1 (automatic allocation, see /proc/misc
>                         or kernel logs)
>
> @@ -89,24 +89,22 @@ statically linked into the kernel). Those options are:
>                         set to 0xffffffff, meaning that all possible events
>                         will be tried. You can use the following bits to
>                         construct your own event mask (from
> -                       drivers/char/sonypi.h):
> +                       drivers/char/sonypi.h)::
>
> -                               ========================        ======
> -                               SONYPI_JOGGER_MASK              0x0001
> -                               SONYPI_CAPTURE_MASK             0x0002
> -                               SONYPI_FNKEY_MASK               0x0004
> -                               SONYPI_BLUETOOTH_MASK           0x0008
> -                               SONYPI_PKEY_MASK                0x0010
> -                               SONYPI_BACK_MASK                0x0020
> -                               SONYPI_HELP_MASK                0x0040
> -                               SONYPI_LID_MASK                 0x0080
> -                               SONYPI_ZOOM_MASK                0x0100
> -                               SONYPI_THUMBPHRASE_MASK         0x0200
> +                               SONYPI_JOGGER_MASK              0x0001
> +                               SONYPI_CAPTURE_MASK             0x0002
> +                               SONYPI_FNKEY_MASK               0x0004
> +                               SONYPI_BLUETOOTH_MASK           0x0008
> +                               SONYPI_PKEY_MASK                0x0010
> +                               SONYPI_BACK_MASK                0x0020
> +                               SONYPI_HELP_MASK                0x0040
> +                               SONYPI_LID_MASK                 0x0080
> +                               SONYPI_ZOOM_MASK                0x0100
> +                               SONYPI_THUMBPHRASE_MASK         0x0200
>                                 SONYPI_MEYE_MASK                0x0400
>                                 SONYPI_MEMORYSTICK_MASK         0x0800
>                                 SONYPI_BATTERY_MASK             0x1000
>                                 SONYPI_WIRELESS_MASK            0x2000
> -                               ========================        ======
>
>         useinput:       if set (which is the default) two input devices are
>                         created, one which interprets the jogdial events as
> diff --git a/Documentation/admin-guide/laptops/toshiba_haps.rst b/Documentation/admin-guide/laptops/toshiba_haps.rst
> index 11dfc428c080..d28b6c3f2849 100644
> --- a/Documentation/admin-guide/laptops/toshiba_haps.rst
> +++ b/Documentation/admin-guide/laptops/toshiba_haps.rst
> @@ -75,11 +75,11 @@ The sysfs files under /sys/devices/LNXSYSTM:00/LNXSYBUS:00/TOS620A:00/ are:
>  protection_level   The protection_level is readable and writeable, and
>                    provides a way to let userspace query the current protection
>                    level, as well as set the desired protection level, the
> -                  available protection levels are:
> +                  available protection levels are::
>
> -                  ============   =======   ==========   ========
> -                  0 - Disabled   1 - Low   2 - Medium   3 - High
> -                  ============   =======   ==========   ========
> +                    ============   =======   ==========   ========
> +                    0 - Disabled   1 - Low   2 - Medium   3 - High
> +                    ============   =======   ==========   ========
>
>  reset_protection   The reset_protection entry is writeable only, being "1"
>                    the only parameter it accepts, it is used to trigger
> diff --git a/Documentation/driver-api/nvdimm/btt.rst b/Documentation/driver-api/nvdimm/btt.rst
> index 2d8269f834bd..107395c042ae 100644
> --- a/Documentation/driver-api/nvdimm/btt.rst
> +++ b/Documentation/driver-api/nvdimm/btt.rst
> @@ -83,7 +83,7 @@ flags, and the remaining form the internal block number.
>  ======== =============================================================
>  Bit      Description
>  ======== =============================================================
> -31 - 30         Error and Zero flags - Used in the following way:
> +31 - 30         Error and Zero flags - Used in the following way::
>
>            == ==  ====================================================
>            31 30  Description
> diff --git a/Documentation/s390/debugging390.rst b/Documentation/s390/debugging390.rst
> index d49305fd5e1a..73ad0b06c666 100644
> --- a/Documentation/s390/debugging390.rst
> +++ b/Documentation/s390/debugging390.rst
> @@ -170,7 +170,7 @@ currently running at.
>  |        +----------------+-------------------------------------------------+
>  |        |    32          | Basic Addressing Mode                           |
>  |        |                |                                                 |
> -|        |                | Used to set addressing mode                     |
> +|        |                | Used to set addressing mode::                   |
>  |        |                |                                                 |
>  |        |                |    +---------+----------+----------+            |
>  |        |                |    | PSW 31  | PSW 32   |          |            |
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
